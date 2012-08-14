Content-Type: multipart/mixed; boundary="===============5757610847601028479=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 7/8] netreg: adapt CMER and CIEV for telit
Date: Tue, 14 Aug 2012 16:16:30 +0200
Message-ID: <502A5DBE.1010404@hale.at>
In-Reply-To: <50292A75.3040005@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5757610847601028479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 13/08/12 18:25, Denis Kenzior wrote:
> Hi Christopher,
>
> On 08/13/2012 08:23 AM, Christopher Vogl wrote:
>> Telit uses a 2 to enable indicator event reporting and
>> indicators in a +CIEV URC are identified by strings, not numbers.
>
> Yikes, can you include a sample AT trace?  It sounds like something is =

> going terribly wrong with CIEVs.
I included a debug output from the start of ofono until a valid ppp =

connection.
I attached it at the end as it is quite long and would make this unreadable.

>
>> ---
>>   drivers/atmodem/network-registration.c |   46 =

>> +++++++++++++++++++++++++-------
>>   1 files changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/atmodem/network-registration.c =

>> b/drivers/atmodem/network-registration.c
>> index 3d09913..7083efe 100644
>> --- a/drivers/atmodem/network-registration.c
>> +++ b/drivers/atmodem/network-registration.c
>> @@ -54,6 +54,7 @@ struct netreg_data {
>>       GAtChat *chat;
>>       char mcc[OFONO_MAX_MCC_LENGTH + 1];
>>       char mnc[OFONO_MAX_MNC_LENGTH + 1];
>> +    const char *signal_identifier;
>>       int signal_index; /* If strength is reported via CIND */
>>       int signal_min; /* min strength reported via CIND */
>>       int signal_max; /* max strength reported via CIND */
>> @@ -734,6 +735,7 @@ static void ciev_notify(GAtResult *result, =

>> gpointer user_data)
>>       struct ofono_netreg *netreg =3D user_data;
>>       struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>>       int strength, ind;
>> +    const char *ind_str;
>>       GAtResultIter iter;
>>
>>       g_at_result_iter_init(&iter, result);
>> @@ -741,11 +743,23 @@ static void ciev_notify(GAtResult *result, =

>> gpointer user_data)
>>       if (!g_at_result_iter_next(&iter, "+CIEV:"))
>>           return;
>>
>> -    if (!g_at_result_iter_next_number(&iter,&ind))
>> -        return;
>> +    /*
>> +     * Telit uses strings to identify indicators.
>> +     */
>> +    if (nd->vendor =3D=3D OFONO_VENDOR_TELIT) {
>> +        if (!g_at_result_iter_next_unquoted_string(&iter,&ind_str))
>> +            return;
>>
>> -    if (ind !=3D nd->signal_index)
>> -        return;
>> +        if (!g_str_equal(nd->signal_identifier, ind_str))
>> +            return;
>> +    }
>> +    else {
>> +        if (!g_at_result_iter_next_number(&iter,&ind))
>> +            return;
>> +
>> +        if (ind !=3D nd->signal_index)
>> +            return;
>> +    }
>
> If Telit is indeed this broken, then likely you can simply create a =

> telit version of this function.  Then you can skip storing =

> nd->signal_identifier and the like.  It would also make things much =

> more readable.
This sounds reasonable - there are too many OFONO_TELIT_VENDORs now anyway.

>
>>
>>       if (!g_at_result_iter_next_number(&iter,&strength))
>>           return;
>> @@ -754,6 +768,8 @@ static void ciev_notify(GAtResult *result, =

>> gpointer user_data)
>>           strength =3D -1;
>>       else
>>           strength =3D (strength * 100) / (nd->signal_max - =

>> nd->signal_min);
>> +
>> +    DBG("Strength: %d", strength);
>
> This might belong in a separate patch.
That was just a debug output that I forgot to remove again.

>
>>
>>       ofono_netreg_strength_notify(netreg, strength);
>>   }
>> @@ -1401,12 +1417,12 @@ static void cind_support_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>       struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>>       GAtResultIter iter;
>>       const char *str;
>> -    char *signal_identifier =3D "signal";
>> +    const char *cmd;
>>       int index;
>>       int min =3D 0;
>>       int max =3D 0;
>>       int tmp_min, tmp_max, invalid;
>> -
>> +
>>       if (!ok)
>>           goto error;
>>
>> @@ -1422,8 +1438,10 @@ static void cind_support_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>        */
>>       if (nd->vendor =3D=3D OFONO_VENDOR_TELIT) {
>>           g_at_result_iter_open_list(&iter);
>> -        signal_identifier =3D "rssi";
>> +        nd->signal_identifier =3D "rssi";
>>       }
>> +    else
>> +        nd->signal_identifier =3D "signal";
>>
>>       while (g_at_result_iter_open_list(&iter)) {
>>           /* Reset invalid default value for every token */
>> @@ -1449,7 +1467,7 @@ static void cind_support_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>           if (!g_at_result_iter_close_list(&iter))
>>               goto error;
>>
>> -        if (g_str_equal(signal_identifier, str) =3D=3D TRUE) {
>> +        if (g_str_equal(nd->signal_identifier, str) =3D=3D TRUE) {
>>               nd->signal_index =3D index;
>>               nd->signal_min =3D min;
>>               nd->signal_max =3D max;
>> @@ -1464,8 +1482,16 @@ static void cind_support_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>
>>       if (nd->signal_index =3D=3D 0)
>>           goto error;
>> -
>> -    g_at_chat_send(nd->chat, "AT+CMER=3D3,0,0,1", NULL,
>> +
>> +    /*
>> +     * Telit uses a 2 to enable indicator event reporting, 1 is =

>> undefined.
>> +     */
>> +    if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
>> +        cmd =3D "AT+CMER=3D3,0,0,2";
>> +    else
>> +        cmd =3D "AT+CMER=3D3,0,0,1";
>> +
>> +    g_at_chat_send(nd->chat, cmd, NULL,
>
> This looks fine, but we might be better off with something similar to =

> how the CNMI string is being built in drivers/atmodem/sms.c. E.g. =

> query which CMER modes are supported and select these intelligently.
Ok thanks, I have had a look at it and I will try to implement it this way.

>
>>               NULL, NULL, NULL);
>>       g_at_chat_register(nd->chat, "+CIEV:",
>>                   ciev_notify, FALSE, netreg, NULL);
>


AT trace with (uncorrected) patches from 1 - 8:

Aug  8 11:35:09 mx31tt01 daemon.info ofonod[496]: oFono version 1.10
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/plugin.c:__ofono_plugin_init()
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/push-notification.c:push_notification_init()
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/smart-messaging.c:smart_messaging_init()
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/cdma-provision.c:ofono_cdma_provision_driver_register() driver: =

0xfb520 name: CDMA provisioning
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs-provision.c:ofono_gprs_provision_driver_register() driver: =

0xfb4f4 name: Provisioning
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/connman.c:connman_init()
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/private-network.c:ofono_private_network_driver_register() driver: =

0xfb4c8, name: ConnMan Private Network
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/dun_gw.c:dun_gw_init()
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb418, name: hfp
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb3c0, name: sap
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb354, name: telit
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb2e8, name: sim900
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb2a0, name: samsung
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb258, name: speedupcdma
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb208, name: speedup
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb1c0, name: alcatel
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb168, name: icera
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb120, name: linktop
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb0d8, name: nokiacdma
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb090, name: nokia
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb048, name: tc65
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfafc0, name: ste
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfaf68, name: ifx
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfaf20, name: palmpre
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfaed0, name: novatel
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfae88, name: sierra
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfae10, name: huawei
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfadc8, name: zte
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfad68, name: hso
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfad18, name: mbm
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfacc8, name: calypso
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfac80, name: wavecom
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfac38, name: g1
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() driver: =

0xfabe0, name: cdmamodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xfac08, name: cdmamodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/cdma-connman.c:ofono_cdma_connman_driver_register() driver: 0xfac24, =

name: cdmamodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfab48, name: phonesim
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfab78, name: localhfp
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfab30, name: =

phonesim
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/ctm.c:ofono_ctm_driver_register() driver: 0xfab1c, name: phonesim
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/phonesim.c:parse_config() filename /etc/ofono/phonesim.conf
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xfab08, name: speedupmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa9fc, name: =

hfpmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xfaaa0, name: hfpmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_driver_register() driver: 0xfaa54, name: hfpmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-volume.c:ofono_call_volume_driver_register() driver: 0xfaa88, =

name: hfpmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/handsfree.c:ofono_handsfree_driver_register() driver: 0xfaacc, name: =

hfpmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_driver_register() driver: 0xfa97c, name: dunmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xfa9a0, name: dunmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa8b4, name: =

stemodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa93c, name: =

stemodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa904, name: stemodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa798, name: =

ifxmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xfa7f0, name: ifxmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa804, name: ifxmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa838, name: =

ifxmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa860, name: ifxmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/ctm.c:ofono_ctm_driver_register() driver: 0xfa880, name: ifxmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa72c, name: =

hsomodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa74c, name: hsomodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa6ac, name: =

mbmmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa6cc, name: mbmmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/location-reporting.c:ofono_location_reporting_driver_register() =

driver: 0xfa6ec, name: mbmmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa614, name: =

calypsomodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa664, name: calypsomodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xfa520, name: huaweimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa534, name: =

huaweimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xfa584, name: huaweimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa5b8, name: huaweimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa598, name: =

huaweimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver: 0xfa5e4, =

name: huaweimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa4ac, name: =

iceramodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa4d4, name: iceramodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa458, name: ztemodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa418, name: =

swmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa3d4, name: nwmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa248, name: =

atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xfa2e0, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-barring.c:ofono_call_barring_driver_register() driver: 0xfa298, =

name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0xfa040, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-meter.c:ofono_call_meter_driver_register() driver: 0xfa080, =

name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-settings.c:ofono_call_settings_driver_register() driver: =

0xf9f8c, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/phonebook.c:ofono_phonebook_driver_register() driver: 0xfa2c8, name: =

atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xfa224, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sms.c:ofono_sms_driver_register() driver: 0xf9ffc, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_driver_register() driver: 0xfa164, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_driver_register() driver: 0xfa1ac, name: atmodem-noef
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa1fc, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_driver_register() driver: 0xfa0dc, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/cbs.c:ofono_cbs_driver_register() driver: 0xfa024, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-volume.c:ofono_call_volume_driver_register() driver: 0xfa30c, =

name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xfa344, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa358, name: =

atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sim-auth.c:ofono_sim_auth_driver_register() driver: 0xfa378, name: =

atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gnss.c:ofono_gnss_driver_register() driver: 0xfa398, name: atmodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9de8, name: gobi
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xf9c7c, name: qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_driver_register() driver: 0xf9ce0, name: qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xf9c98, name: =

qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_driver_register() driver: 0xf9d04, name: qmimodem-legacy
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sms.c:ofono_sms_driver_register() driver: 0xf9d4c, name: qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xf9d6c, name: qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xf9d80, name: qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xf9d94, name: =

qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xf9dac, name: qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/location-reporting.c:ofono_location_reporting_driver_register() =

driver: 0xf9dd0, name: qmimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9c14, name: u8500
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xf9bf8, name: u8500
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9bb0, name: n900
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9b68, name: isiusb
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xf991c, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/phonebook.c:ofono_phonebook_driver_register() driver: 0xf990c, name: =

isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_driver_register() driver: 0xf9938, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xf995c, name: =

isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sms.c:ofono_sms_driver_register() driver: 0xf99a4, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/cbs.c:ofono_cbs_driver_register() driver: 0xf99c4, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_driver_register() driver: 0xf99d8, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xf9a20, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0xf9a34, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-settings.c:ofono_call_settings_driver_register() driver: =

0xf9a54, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-barring.c:ofono_call_barring_driver_register() driver: 0xf9a84, =

name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/call-meter.c:ofono_call_meter_driver_register() driver: 0xf9a9c, =

name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xf9ac4, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xf9ae8, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xf9afc, name: =

isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xf9b14, name: isimodem
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_driver_register() driver: 0xf9b20, name: wgmodem2.5
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:udev_start()
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:enumerate_devices()
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() hub [(null):(null)]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() usb [0424:2514]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() usb [1bc7:1004]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.0/ttyUSB0/tty/ttyUS=
B0
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() /dev/ttyUSB0 (telit) 255/255/255 [00] =3D=3D> =

(null) (null)
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.1/ttyUSB1/tty/ttyUS=
B1
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() /dev/ttyUSB1 (telit) 255/255/255 [01] =3D=3D> =

(null) (null)
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.2/ttyUSB2/tty/ttyUS=
B2
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() /dev/ttyUSB2 (telit) 255/255/255 [02] =3D=3D> =

(null) (null)
Aug  8 11:35:09 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.3/ttyUSB3/tty/ttyUS=
B3
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:add_device() /dev/ttyUSB3 (telit) 255/255/255 [03] =3D=3D> =

(null) (null)
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() usb [9710:7830]
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() MOSCHIP usb-ethernet driver =

[(null):(null)]
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() MOSCHIP usb-ethernet driver [9710:7830]
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_usb_device() hub [(null):(null)]
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:create_modem() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:create_modem() driver=3Dtelit
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_create() name: (null), type: telit
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:setup_telit() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB0 255/255/255 00 (null)
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB1 255/255/255 01 (null)
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/255/255 02 (null)
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255 03 (null)
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB0 aux=3D/dev/ttyUSB3 =

gps=3D/dev/ttyUSB2 diag=3D/dev/ttyUSB1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:set_modem_property() modem 0x1f532d8 property Modem
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:set_modem_property() modem 0x1f532d8 property Aux
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:set_modem_property() modem 0x1f532d8 property GPS
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:ofono_modem_register() 0x1f532d8
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_probe() 0x1f532d8
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:emit_modem_added() 0x1f532d8
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:call_modemwatches() 0x1f532d8 added:1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/hfp_ag.c:modem_watch() modem: 0x1f532d8, added: 1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/dun_gw.c:modem_watch() modem: 0x1f532d8, added: 1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/smart-messaging.c:modem_watch() modem: 0x1f532d8, added: 1
Aug  8 11:35:10 mx31tt01 daemon.debug ofonod[496]: =

plugins/push-notification.c:modem_watch() modem: 0x1f532d8, added: 1
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_enable() 0x1f532d8
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:get_modem_property() modem 0x1f532d8 property Modem
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:open_device() Modem /dev/ttyUSB0
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:get_modem_property() modem 0x1f532d8 property Aux
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:open_device() Aux /dev/ttyUSB3
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > ATE0 +CMEE=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CFUN=3D4\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:cfun_enable_cb() 0x1f532d8
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:modem_change_state() old state: 0, new state: 1
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_pre_sim() 0x1f532d8
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:telit_hale_enable_sim()
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 0, success 1
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:telit_hale_enable_sim() done.
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT&C0\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+GCAP\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+GCAP: =

+CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRC=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_add_state_watch() 0x1f4e4a8
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_add_state_watch() 0x1f4e4a8
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_add_state_watch() 0x1f4e4a8
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CLIP=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_set_online() modem 0x1f532d8 online
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CDIP=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nERROR\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CNAP=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nERROR\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COLP=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CME ERROR: =

10\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CSSN=3D1,1\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CME ERROR: =

10\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+VTD?\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CME ERROR: =

10\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CCWA=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CME ERROR: =

10\r\n
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/voicecall.c:at_voicecall_initialized() voicecall_init: =

registering to notifications
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_add_state_watch() 0x1f4e4a8
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT#QSS=3D2\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT$GPSAT=3D1\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 1, success 1
Aug  8 11:35:14 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGMI\r
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: < =

\r\nTelit\r\n\r\nOK\r\n
Aug  8 11:35:14 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CFUN=3D1\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:common_online_cb() Online in PRE SIM state
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CLCC\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CME ERROR: =

14\r\n
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT$GPSP=3D1\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 2, success 1
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGMM\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < =

\r\nUC864-G\r\n\r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT#SIMDET=3D0\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 3, success 1
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGMR\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < =

\r\n08.01.107\r\n\r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT#GPIO=3D1,1,0\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 4, success 1
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGSN\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < =

\r\n356265021069520\r\n\r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT#GPIO=3D2,1,0\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 5, success 1
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: > AT#GPIO=3D1,0,1\r
Aug  8 11:35:16 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 6, success 1
Aug  8 11:35:16 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 7, success 1
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker()
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_sim_worker() done.
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:telit_hale_enable_automatic_sim_detection()
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 0, success 1
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_autosimdet_worker()
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:telit_hale_enable_automatic_sim_detection() done.
Aug  8 11:35:22 mx31tt01 daemon.info ofonod[496]: Aux: > AT#SIMDET=3D2\r
Aug  8 11:35:22 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:state_worker() state: step 1, success 1
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_autosimdet_worker()
Aug  8 11:35:22 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit-hale.c:enable_autosimdet_worker() done.
Aug  8 11:35:26 mx31tt01 daemon.info ofonod[496]: Modem: < \r\n#QSS: 2\r\n
Aug  8 11:35:26 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n#QSS: 2\r\n
Aug  8 11:35:26 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_qss_notify() 0x1f532d8
Aug  8 11:35:26 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:switch_sim_state_status() 0x1f532d8
Aug  8 11:35:26 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:switch_sim_state_status() SIM inserted and PIN unlocked
Aug  8 11:35:30 mx31tt01 daemon.info ofonod[496]: Modem: < \r\n#PSNT: 1\r\n
Aug  8 11:35:30 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n#PSNT: 1\r\n
Aug  8 11:35:54 mx31tt01 daemon.info ofonod[496]: Modem: < \r\n#PSNT: 2\r\n
Aug  8 11:35:54 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n#PSNT: 2\r\n
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Modem: < \r\n#QSS: 3\r\n
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n#QSS: 3\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_qss_notify() 0x1f532d8
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:switch_sim_state_status() 0x1f532d8
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:switch_sim_state_status() SIM inserted and ready
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2859=
9\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,62228205022100100383026FB7A5038001318A01058B036F060680020030880108F10=
100\r\n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 36
Aug  8 11:35:58 mx31tt01 daemon.err ofonod[496]: Requested file =

structure differs from SIM: 6fb7
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ecc_g2_read_cb() 0
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2859=
9\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,62228205022100100383026FB7A5038001318A01058B036F060680020030880108F10=
100\r\n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 36
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28599,1,4,16\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 16
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ecc_g3_read_cb() 1
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28599,2,4,16\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 16
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ecc_g3_read_cb() 1
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28599,3,4,16\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 16
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

src/voicecall.c:ecc_g3_read_cb() 1
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,1225=
8\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,621F8202012183022FE2A5038001318A01058B032F06038002000A880110F10100\r\=
n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D176,12258,0,0,10\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,98343000000163500864\r\n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 10
Aug  8 11:35:58 mx31tt01 daemon.debug ofonod[496]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 10
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2842=
1\r
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug  8 11:35:58 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,1203=
7\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,621F8202012183022F05A5038001318A01058B032F060480020008880128F10100\r\=
n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D176,12037,0,0,8\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,6465656EFFFFFFFF\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 8
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 8
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CPIN?\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CPIN: =

READY\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_pin_retries_query()
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT#PCT\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n#PCT: =

3\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_pct_cb() Note: No password required, returning =

maximum retries:
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D1, val=3D3
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D4, val=3D3
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D9, val=3D10
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D11, val=3D10
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2859=
0\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CME ERROR: =

22\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2858=
9\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,621F8202012183026FADA5038001318A01058B036F060680020004880118F10100\r\=
n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D176,28589,0,0,4\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,00FFFF02\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 4
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 4
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2843=
8\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2847=
2\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,621F8202012183026F38A5038001318A01058B036F060580020008880120F10100\r\=
n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D176,28472,0,0,8\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,822B170C23460800\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 8
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 8
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2850=
2\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,621F8202012183026F56A5038001318A01058B036F061180020001880128F10100\r\=
n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D176,28502,0,0,1\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,00\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 1
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 1
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CIMI\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < =

\r\n232033012792309\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 232033012792309
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:modem_change_state() old state: 1, new state: 2
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_post_sim() 0x1f532d8
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

src/modem.c:modem_change_state() old state: 2, new state: 3
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

plugins/telit.c:telit_post_online() 0x1f532d8
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/gprs-context.c:at_gprs_context_probe()
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CSMS=3D?\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CSMS: =

(0,1)\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sms.c:at_csms_query_cb() CSMS query parsed successfully
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CREG=3D?\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CREG: =

(0-2)\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CSCS?\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CSCS: =

"IRA"\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CUSD=3D1\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CAOC=3D2\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CCWE=3D1\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nERROR\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGDCONT=3D?\r
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CGDCONT: =

(1-16),"IP",,,(0-2),(0-4)\r\n+CGDCONT: =

(1-16),"PPP",,,(0-2),(0-4)\r\n+CGDCONT: =

(1-16),"IPV6",,,(0-2),(0-4)\r\n\r\nOK\r\n
Aug  8 11:35:59 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2848=
0\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,622182050221001E0483026F40A5038001318A01058B036F060B800200788800F1010=
0\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CSMS=3D1\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CSMS: =

1,1,1\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CREG=3D2\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGREG=3D?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CGREG: =

(0-2)\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28480,1,4,30\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,456967656E65205275666E756D6D65720791347676086013FFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CSMS?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CSMS: =

1,1,1,1\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CIND=3D?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIND: =

(("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounder",(0,1=
)),("message",(0,1)),("call",(0,1)),("roam",(0,1)),("smsfull",(0
,1)),("rssi",(0-5,99)))\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

src/sim.c:ofono_sim_add_spn_watch() 0x1f4e4a8
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGREG=3D2\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT#AUTOATT=3D0\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGEREP=3D2,1\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:__ofono_netreg_add_status_watch() 0x1f605f8
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28480,2,4,30\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CMGF=3D?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CMGF: =

(0,1)\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CMER=3D3,0,0,2\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CREG?\r

Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIEV: =

battchg,5\r\n\r\n+CIEV: signal,0\r\n\r\n+CIEV: service,1\r\n\r\n+CIEV: =

sounder,0\r\n\r\n+CIEV: message,1\r\n\r\n+CIEV: call,0\r\n\r\n+CIEV:
  roam,0\r\n\r\n+CIEV: smsfull,0\r\n\r\n+CIEV: rssi,1\r\n

Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:ciev_notify() Strength: 20
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CREG: =

2,1,"EF10","022306B"\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech -1
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:netreg_status_changed() 1
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT#PSNT=3D1\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT#PSNT?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n#PSNT: =

1,2\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28480,3,4,30\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CPMS=3D?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CPMS: =

("ME","SM","SR"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,2\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,2,"23203",2\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 232, mnc: 03
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CIND?\r
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIND: =

5,99,1,0,1,0,0,0,1\r\n\r\nOK\r\n
Aug  8 11:36:00 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_strength_notify() strength 20
Aug  8 11:36:00 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGATT=3D1\r

Aug  8 11:36:02 mx31tt01 daemon.info ofonod[496]: Modem: < \r\n+CIEV: =

rssi,3\r\n

Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:gprs_attach_callback() /telit_0 error =3D 0
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CIND?\r

Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIEV: =

rssi,3\r\n

Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:ciev_notify() Strength: 60
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_strength_notify() strength 60
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Modem: < \r\n+CREG: =

1,"EF10","0000"\r\n\r\n+CGREG: 2\r\n\r\n#PSNT: 1\r\n
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CREG: =

1,"EF10","0000"\r\n\r\n+CGREG: 2\r\n\r\n#PSNT: 1\r\n\r\n+CIND: =

4,99,1,0,1,0,0,0,3\r\n\r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech -1
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:netreg_status_changed() 1
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28480,4,4,30\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CMGF=3D0\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,0\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,0,"T-Mobile A",0\r\n\r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: T-Mobile A, =

232 03 0
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:current_operator_callback() 0x1f605f8, (nil)
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:netreg_status_changed() 1
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGREG?\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CGREG: =

2,2\r\n\r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:registration_status_cb() /telit_0 error 0 status 2
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,2\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,2,"23203",0\r\n\r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 232, mnc: 03
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CIND?\r
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIND: =

5,99,1,0,1,0,0,0,3\r\n\r\nOK\r\n
Aug  8 11:36:03 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2848=
9\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CPMS=3D"ME","ME","ME"\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CPMS: =

0,50,0,50,0,50\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,0\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,0,"T-Mobile A",0\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: T-Mobile A, =

232 03 0
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:current_operator_callback() 0x1f605f8, 0x1f549d8
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2861=
8\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,62218205022100050183026FCAA5038001318A01058B036F060B800200058800F1010=
0\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CNMI=3D?\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CNMI: =

(0-3),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sms.c:build_cnmi_string()
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sms.c:construct_ack_pdu()
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28618,1,4,5\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,0000000000\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 5
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CNMI=3D2,2,2,1,=
0\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:__ofono_netreg_add_status_watch() 0x1f605f8
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

src/sms.c:sms_restore_tx_queue()
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

plugins/push-notification.c:sms_watch() registered
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

plugins/smart-messaging.c:sms_watch() registered
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2861=
7\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,62218205022100040183026FC9A5038001318A01058B036F060B800200048800F1010=
0\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CMGL=3D4\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sms.c:at_cmgl_done()
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CGSMS=3D3\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28617,1,4,4\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,01000000\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 4
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2843=
3\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2843=
5\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, toread: 17
Aug  8 11:36:04 mx31tt01 daemon.err ofonod[496]: EFspn read =

successfully, but couldn't parse
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2843=
7\r
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug  8 11:36:04 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CRSM=3D192,2861=
5\r
Aug  8 11:36:05 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,622182050221001E0183026FC7A5038001318A01058B036F060B8002001E8800F1010=
0\r\n\r\nOK\r\n
Aug  8 11:36:05 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug  8 11:36:05 mx31tt01 daemon.info ofonod[496]: Aux: > =

AT+CRSM=3D178,28615,1,4,30\r
Aug  8 11:36:05 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CRSM: =

144,0,542D4D6F62696C6520426F78FFFFFFFF069134762602F0FFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug  8 11:36:05 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug  8 11:36:06 mx31tt01 daemon.info ofonod[496]: Modem: < \r\n+CGREG: =

1,"271B","3068"\r\n
Aug  8 11:36:06 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CGREG: =

1,"271B","3068"\r\n
Aug  8 11:36:06 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
Aug  8 11:36:07 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: Modem: > =

AT+CGDCONT=3D1,"IP","gprswap"\r
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: Modem: < \r\nOK\r\n
Aug  8 11:36:07 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: Modem: > =

AT+CGDATA=3D"PPP",1\r
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: Modem: < \r\nCONNECT\r\n
Aug  8 11:36:07 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
Aug  8 11:36:07 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/gprs-context.c:setup_ppp()
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_generate_event: current state 0:INITIAL
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: event: 0 (Up), =

action: 2, new_state: 2 (CLOSED)
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_generate_event: current state 2:CLOSED
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: event: 2 (Open), =

action: 1026, new_state: 6 (REQSENT)
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_initialize_restart_count: current state 2:CLOSED
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_send_configure_request: current state 2:CLOSED
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 1
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_process_configure_request: current state 6:REQSENT
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_generate_event: current state 6:REQSENT
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: event: 6 (RCR+), =

action: 2008, new_state: 8 (ACKSENT)
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_send_configure_ack: current state 6:REQSENT
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_process_configure_ack: current state 8:ACKSENT
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: event: 8 (RCA), =

action: 129, new_state: 9 (OPENED)
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: lcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 2
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 3
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 0:INITIAL
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: event: 2 (Open), =

action: 401, new_state: 1 (STARTING)
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 1:STARTING
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: event: 0 (Up), =

action: 1026, new_state: 6 (REQSENT)
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 1:STARTING
Aug  8 11:36:07 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 1:STARTING
Aug  8 11:36:08 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Aug  8 11:36:08 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Aug  8 11:36:08 mx31tt01 daemon.info ofonod[496]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Aug  8 11:36:08 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Aug  8 11:36:08 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Aug  8 11:36:09 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Aug  8 11:36:09 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Aug  8 11:36:09 mx31tt01 daemon.info ofonod[496]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Aug  8 11:36:09 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Aug  8 11:36:09 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Aug  8 11:36:10 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Aug  8 11:36:10 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Aug  8 11:36:10 mx31tt01 daemon.info ofonod[496]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Aug  8 11:36:10 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Aug  8 11:36:10 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Aug  8 11:36:11 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Aug  8 11:36:11 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Aug  8 11:36:11 mx31tt01 daemon.info ofonod[496]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Aug  8 11:36:11 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Aug  8 11:36:11 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_request: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: event: 6 (RCR+), =

action: 2008, new_state: 8 (ACKSENT)
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_ack: current state 6:REQSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_reject: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: event: 9 (RCN), =

action: 1028, new_state: 8 (ACKSENT)
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_nak: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: event: 9 (RCN), =

action: 1028, new_state: 8 (ACKSENT)
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_send_configure_request: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_process_configure_ack: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: event: 8 (RCA), =

action: 129, new_state: 9 (OPENED)
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 4
Aug  8 11:36:12 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/gprs-context.c:ppp_connect()
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: IP: 10.146.129.101
Aug  8 11:36:12 mx31tt01 daemon.info ofonod[496]: DNS: 213.162.69.169, =

213.162.69.170
Aug  8 11:36:12 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:pri_activate_callback() 0x1f55368
Aug  8 11:36:12 mx31tt01 daemon.debug ofonod[496]: =

plugins/udev.c:udev_event() subsystem net add
Aug  8 11:36:12 mx31tt01 daemon.debug ofonod[496]: =

plugins/udev.c:udev_event() subsystem net finished
Aug  8 11:36:13 mx31tt01 daemon.debug ofonod[496]: =

plugins/udevng.c:check_modem_list()
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CREG: =

1,"271B","4C48"\r\n
Aug  8 11:39:07 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech -1
Aug  8 11:39:07 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:netreg_status_changed() 1
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,2\r
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CGREG: =

1,"271B","4C48"\r\n
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:39:07 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,2,"23203",0\r\n\r\nOK\r\n
Aug  8 11:39:07 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 232, mnc: 03
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CIND?\r
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIND: =

4,99,1,0,1,0,0,0,3\r\n\r\nOK\r\n
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,0\r
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:39:07 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,0,"T-Mobile A",0\r\n\r\nOK\r\n
Aug  8 11:39:07 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: T-Mobile A, =

232 03 0
Aug  8 11:39:07 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:current_operator_callback() 0x1f605f8, 0x1f549d8

Aug  8 11:39:46 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIEV: =

rssi,2\r\n

Aug  8 11:39:46 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:ciev_notify() Strength: 40
Aug  8 11:39:46 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_strength_notify() strength 40

Aug  8 11:39:52 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIEV: =

rssi,1\r\n

Aug  8 11:39:52 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:ciev_notify() Strength: 20
Aug  8 11:39:52 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_strength_notify() strength 20
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CREG: =

1,"271B","3068"\r\n
Aug  8 11:39:53 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech -1
Aug  8 11:39:53 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:netreg_status_changed() 1
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,2\r
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CGREG: =

1,"271B","3068"\r\n\r\nOK\r\n
Aug  8 11:39:53 mx31tt01 daemon.debug ofonod[496]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,2,"23203",0\r\n\r\nOK\r\n
Aug  8 11:39:53 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 232, mnc: 03
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: > AT+CIND?\r
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIND: =

4,99,1,0,1,0,0,0,1\r\n\r\nOK\r\n
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS=3D3,0\r
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: < \r\nOK\r\n
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: > AT+COPS?\r
Aug  8 11:39:53 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+COPS: =

0,0,"T-Mobile A",0\r\n\r\nOK\r\n
Aug  8 11:39:53 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: T-Mobile A, =

232 03 0
Aug  8 11:39:53 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:current_operator_callback() 0x1f605f8, 0x1f549d8

Aug  8 11:39:56 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIEV: =

rssi,3\r\n

Aug  8 11:39:56 mx31tt01 daemon.debug ofonod[496]: =

drivers/atmodem/network-registration.c:ciev_notify() Strength: 60
Aug  8 11:39:56 mx31tt01 daemon.debug ofonod[496]: =

src/network.c:ofono_netreg_strength_notify() strength 60

Aug  8 11:40:11 mx31tt01 daemon.info ofonod[496]: Aux: < \r\n+CIEV: =

rssi,2\r\n



Regards,
Christopher

--
Scanned by MailScanner.


--===============5757610847601028479==--

