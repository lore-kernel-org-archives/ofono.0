Content-Type: multipart/mixed; boundary="===============4321209105996070398=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH 4/5] push notification: track and clean up atom watches
Date: Tue, 26 Apr 2016 06:03:55 +0000
Message-ID: <571F04C7.1060808@actia.se>
In-Reply-To: <571E6848.2080408@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4321209105996070398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/25/2016 08:56 PM, Denis Kenzior wrote:
> Hi John,
>
> On 04/25/2016 02:02 AM, John Ernberg wrote:
>> Hi Denis,
>>
>> On 04/22/2016 09:43 PM, Denis Kenzior wrote:
>>> Hi John,
>>>
>>> On 04/22/2016 08:07 AM, John Ernberg wrote:
>>>> From: John Ernberg <john.ernberg@actia.se>
>>>>
>>>> Prevents glib from causing SIGFPE during certain circumstances of =

>>>> modem
>>>> removal.
>>>
>>> Do you have a stack trace handy?
>> I have one for the bluez5 hfp plugin which was recreated by stopping
>> oFono, the rest of the changes were added as a sort of safeguard.
>>
>> Stack trace:
>>
>> (gdb)
>> (gdb) bt
>> #0  0x76d88748 in raise (sig=3D8)
>>       at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:37
>> #1  0x76e8bcac in __aeabi_ldiv0 ()
>>       at
>> /opt/yocto/build/tmp/work-shared/gcc-4.8.2-r0/gcc-4.8.2/libgcc/config/ar=
m/lib1funcs.S:1331 =

>>
>> #2  0x76e0e1b4 in g_hash_table_lookup_node (hash_return=3D<synthetic
>> pointer>,
>>       key=3D0xe17418, hash_table=3D0xe10e38)
>>       at =

>> /usr/src/debug/glib-2.0/1_2.38.2-r0/glib-2.38.2/glib/ghash.c:371
>> #3  g_hash_table_lookup (hash_table=3D0xe10e38, key=3Dkey(a)entry=3D0xe1=
7418)
>>       at =

>> /usr/src/debug/glib-2.0/1_2.38.2-r0/glib-2.38.2/glib/ghash.c:1076
>> #4  0x0008ccb8 in sim_watch (atom=3D<optimized out>, cond=3D<optimized o=
ut>,
>>       data=3D0xe18f88) at plugins/hfp_ag_bluez5.c:260
>> #5  0x000910d0 in call_watches (atom=3Datom(a)entry=3D0xe17540,
>>       cond=3Dcond(a)entry=3DOFONO_ATOM_WATCH_CONDITION_UNREGISTERED) at
>> src/modem.c:261
>> #6  0x00091de0 in __ofono_atom_unregister (atom=3Datom(a)entry=3D0xe1754=
0)
>>       at src/modem.c:281
>> #7  0x00091e54 in flush_atoms (
>>       new_state=3Dnew_state(a)entry=3DMODEM_STATE_POWER_OFF, modem=3D0xe=
18f88)
>>       at src/modem.c:430
>> #8  0x00091f60 in modem_change_state (modem=3D0xe18f88,
>>       new_state=3DMODEM_STATE_POWER_OFF) at src/modem.c:511
>> #9  0x000921c8 in set_powered (modem=3Dmodem(a)entry=3D0xe18f88,
>>       powered=3Dpowered(a)entry=3D0) at src/modem.c:882
>> #10 0x00092990 in modem_unregister (modem=3D0xe18f88) at src/modem.c:2040
>> #11 0x00093cec in ofono_modem_driver_unregister (d=3D0x112168)
>>       at src/modem.c:2176
>
> What calls this?  The corresponding exit function in question is not =

> present in the stack trace.
The modem plugins call it during their exit. Since the plugins are all =

calling exit the drivers gets unregistered.
>
>> #12 0x00091040 in __ofono_plugin_cleanup () at src/plugin.c:197
>> #13 0x00014e24 in main (argc=3D85540, argv=3D0x7ee60d44) at src/main.c:2=
55
>>
>> oFono debug log:
>>
>> ofonod[5126]: src/plugin.c:__ofono_plugin_cleanup()
>> ofonod[5126]: plugins/push-notification.c:push_notification_exit()
>> ofonod[5126]: plugins/smart-messaging.c:smart_messaging_exit()
>> ofonod[5126]: plugins/bluez5.c:bt_unregister_profile() Bluetooth:
>> Unregistering profile /bluetooth/profile/dun_gw
>> ofonod[5126]: plugins/bluez5.c:bt_unregister_profile() Bluetooth:
>> Unregistering profile /bluetooth/profile/hfp_hf
>> ofonod[5126]:
>> src/handsfree-audio.c:ofono_handsfree_card_driver_unregister() driver:
>> 0x113994
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1139a4, name: hfp
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x11391c, name: ublox
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1138b4, name: quectel
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113854, name: he910
>> ofonod[5126]:
>> src/private-network.c:ofono_private_network_driver_unregister() driver:
>> 0x113828, name: ConnMan Private Network
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1137d0, name: sim900
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113778, name: samsung
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113720, name: speedupcdma
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1136c0, name: speedup
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113668, name: alcatel
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113600, name: icera
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1135a8, name: linktop
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113550, name: nokiacdma
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1134f8, name: nokia
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1134a0, name: tc65
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113408, name: ste
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1133a0, name: ifx
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113348, name: palmpre
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1132e8, name: novatel
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113290, name: sierra
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113208, name: huawei
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1131b0, name: zte
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113140, name: hso
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x1130e0, name: mbm
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113080, name: calypso
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x113028, name: wavecom
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x112fd0, name: g1
>> ofonod[5126]:
>> src/cdma-voicecall.c:ofono_cdma_voicecall_driver_unregister() driver:
>> 0x112f78, name: cdmamodem
>> ofonod[5126]: src/modem.c:ofono_devinfo_driver_unregister() driver:
>> 0x112fa0, name: cdmamodem
>> ofonod[5126]: src/cdma-connman.c:ofono_cdma_connman_driver_unregister()
>> driver: 0x112fbc, name: cdmamodem
>> ofonod[5126]: src/ctm.c:ofono_ctm_driver_unregister() driver: 0x112e88,
>> name: phonesim
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x112e9c, name: phonesim
>> ofonod[5126]: src/modem.c:ofono_modem_driver_unregister() driver:
>> 0x112eb8, name: phonesim
>> ofonod[5126]: src/ussd.c:ofono_ussd_driver_unregister() driver:
>> 0x112e74, name: speedupmodem
>> ofonod[5126]: src/voicecall.c:ofono_voicecall_driver_unregister()
>> driver: 0x112d38, name: hfpmodem
>> ofonod[5126]: src/modem.c:ofono_devinfo_driver_unregister() driver:
>> 0x112ddc, name: hfpmodem
>> ofonod[5126]: src/network.c:ofono_netreg_driver_unregister() driver:
>> 0x112d90, name: hfpmodem
>> ofonod[5126]: src/call-volume.c:ofono_call_volume_driver_unregister()
>> driver: 0x112dc4, name: hfpmodem
>> ofonod[5126]: src/handsfree.c:ofono_handsfree_driver_unregister()
>> driver: 0x112e08, name: hfpmodem
>> ofonod[5126]: src/siri.c:ofono_siri_driver_unregister() driver:
>> 0x112e3c, name: hfpmodem
>> ofonod[5126]: src/network.c:ofono_netreg_driver_unregister() driver:
>> 0x112cb8, name: dunmodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_driver_unregister() driver:
>> 0x112cdc, name: dunmodem
>> ofonod[5126]: src/voicecall.c:ofono_voicecall_driver_unregister()
>> driver: 0x112bec, name: stemodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x112c74, name: stemodem
>> ofonod[5126]:
>> src/radio-settings.c:ofono_radio_settings_driver_unregister() driver:
>> 0x112c3c, name: stemodem
>> ofonod[5126]: src/stk.c:ofono_stk_driver_unregister() driver: 0x112b98,
>> name: ifxmodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x112b6c, name: ifxmodem
>> ofonod[5126]:
>> src/radio-settings.c:ofono_radio_settings_driver_unregister() driver:
>> 0x112b38, name: ifxmodem
>> ofonod[5126]:
>> src/audio-settings.c:ofono_audio_settings_driver_unregister() driver:
>> 0x112b24, name: ifxmodem
>> ofonod[5126]: src/voicecall.c:ofono_voicecall_driver_unregister()
>> driver: 0x112acc, name: ifxmodem
>> ofonod[5126]: src/ctm.c:ofono_ctm_driver_unregister() driver: 0x112bb8,
>> name: ifxmodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x112a5c, name: hsomodem
>> ofonod[5126]:
>> src/radio-settings.c:ofono_radio_settings_driver_unregister() driver:
>> 0x112a80, name: hsomodem
>> ofonod[5126]:
>> src/location-reporting.c:ofono_location_reporting_driver_unregister()
>> driver: 0x112a1c, name: mbmmodem
>> ofonod[5126]: src/stk.c:ofono_stk_driver_unregister() driver: 0x1129fc,
>> name: mbmmodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x1129d8, name: mbmmodem
>> ofonod[5126]: src/stk.c:ofono_stk_driver_unregister() driver: 0x112990,
>> name: calypsomodem
>> ofonod[5126]: src/voicecall.c:ofono_voicecall_driver_unregister()
>> driver: 0x112940, name: calypsomodem
>> ofonod[5126]: src/cdma-netreg.c:ofono_cdma_netreg_driver_unregister()
>> driver: 0x112910, name: huaweimodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x1128c0, name: huaweimodem
>> ofonod[5126]:
>> src/radio-settings.c:ofono_radio_settings_driver_unregister() driver:
>> 0x1128e4, name: huaweimodem
>> ofonod[5126]:
>> src/audio-settings.c:ofono_audio_settings_driver_unregister() driver:
>> 0x1128ac, name: huaweimodem
>> ofonod[5126]: src/voicecall.c:ofono_voicecall_driver_unregister()
>> driver: 0x11285c, name: huaweimodem
>> ofonod[5126]: src/ussd.c:ofono_ussd_driver_unregister() driver:
>> 0x112848, name: huaweimodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x1127d0, name: iceramodem
>> ofonod[5126]:
>> src/radio-settings.c:ofono_radio_settings_driver_unregister() driver:
>> 0x1127fc, name: iceramodem
>> ofonod[5126]:
>> src/radio-settings.c:ofono_radio_settings_driver_unregister() driver:
>> 0x11277c, name: ztemodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x112738, name: swmodem
>> ofonod[5126]:
>> src/radio-settings.c:ofono_radio_settings_driver_unregister() driver:
>> 0x1126f4, name: nwmodem
>> ofonod[5126]: src/sim-auth.c:ofono_sim_auth_driver_unregister() driver:
>> 0x112698, name: atmodem
>> ofonod[5126]: src/stk.c:ofono_stk_driver_unregister() driver: 0x112520,
>> name: atmodem
>> ofonod[5126]: src/sim.c:ofono_sim_driver_unregister() driver: 0x112488,
>> name: atmodem
>> ofonod[5126]: src/sim.c:ofono_sim_driver_unregister() driver: 0x1124d0,
>> name: atmodem-noef
>> ofonod[5126]: src/sms.c:ofono_sms_driver_unregister() driver: 0x1122e0,
>> name: atmodem
>> ofonod[5126]: src/ussd.c:ofono_ussd_driver_unregister() driver:
>> 0x112548, name: atmodem
>> ofonod[5126]: src/phonebook.c:ofono_phonebook_driver_unregister()
>> driver: 0x1125ec, name: atmodem
>> ofonod[5126]:
>> src/call-settings.c:ofono_call_settings_driver_unregister() driver:
>> 0x112270, name: atmodem
>> ofonod[5126]: src/call-meter.c:ofono_call_meter_driver_unregister()
>> driver: 0x112364, name: atmodem
>> ofonod[5126]:
>> src/call-forwarding.c:ofono_call_forwarding_driver_unregister() driver:
>> 0x112324, name: atmodem
>> ofonod[5126]: src/call-barring.c:ofono_call_barring_driver_unregister()
>> driver: 0x1125bc, name: atmodem
>> ofonod[5126]: src/network.c:ofono_netreg_driver_unregister() driver:
>> 0x1123d0, name: atmodem
>> ofonod[5126]: src/modem.c:ofono_devinfo_driver_unregister() driver:
>> 0x112604, name: atmodem
>> ofonod[5126]: src/voicecall.c:ofono_voicecall_driver_unregister()
>> driver: 0x11256c, name: atmodem
>> ofonod[5126]: src/cbs.c:ofono_cbs_driver_unregister() driver: 0x112308,
>> name: atmodem
>> ofonod[5126]: src/call-volume.c:ofono_call_volume_driver_unregister()
>> driver: 0x112630, name: atmodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_driver_unregister() driver:
>> 0x112660, name: atmodem
>> ofonod[5126]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
>> 0x112674, name: atmodem
>> ofonod[5126]: src/gnss.c:ofono_gnss_driver_unregister() driver:
>> 0x1126b8, name: atmodem
>> ofonod[5126]: src/modem.c:modem_unregister() 0xe18f88
>> ofonod[5126]: src/modem.c:modem_change_state() old state: 3, new =

>> state: 0
>
> Are you running a modified version of oFono by any chance?  The =

> upstream version handles SIGINT and SIGTERM by calling =

> __ofono_modem_shutdown. Which in turn flushes all atoms and all the =

> various watches are cleaned up.
In the embedded system where I run oFono I have not figured out how to =

get the stack tracing implemented in src/log.c working so that is disabled.
I have not done any changes to src/main.c or src/log.c except disabling =

the internal stack trace.
>
> Only after all the modems are shut down do we exit the event loop and =

> __ofono_plugin_cleanup is called.  The fact that you still have a =

> modem in state MODEM_STATE_ONLINE here is a bit puzzling.
>
> However, even if I take out that logic and force the debug log to look =

> like yours, the only problems I detect are in the hfp_ag_bluez5 plugin =

> and examples/emulator.c plugin.
Hm, if it doesn't happen in upstream this is also probably PEBKAC on my =

part somehow.
>
>> ofonod[5126]: src/modem.c:flush_atoms()
>> ofonod[5126]: src/sim.c:ofono_sim_remove_spn_watch() 0xe17418
>> ofonod[5126]: src/network.c:netreg_remove() atom: 0xe17af8
>> ofonod[5126]: src/voicecall.c:voicecall_remove() atom: 0xe17c58
>> ofonod[5126]: src/gprs.c:gprs_context_unregister() 0xe17cd8, 0xe17a30
>> ofonod[5126]: src/gprs.c:gprs_context_remove() atom: 0xe17cf8
>> ofonod[5126]: drivers/atmodem/gprs-context.c:at_gprs_context_remove()
>> ofonod[5126]: src/gprs.c:gprs_unregister() 0xe17a30
>> ofonod[5126]: src/gprs.c:gprs_remove() atom: 0xe17b48
>> ofonod[5126]: plugins/push-notification.c:push_notification_cleanup()
>> 0xe1adb0
>> ofonod[5126]: plugins/smart-messaging.c:smart_messaging_cleanup() =

>> 0xe1ad80
>> ofonod[5126]: src/sms.c:sms_remove() atom: 0xe175a0
>> Floating point exception (core dumped)
>>
>>>
>>>> ---
>>>>    plugins/push-notification.c | 26 +++++++++++++++++++++++---
>>>>    1 file changed, 23 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/plugins/push-notification.c b/plugins/push-notification.c
>>>> index ff388d9..ecf100f 100644
>>>> --- a/plugins/push-notification.c
>>>> +++ b/plugins/push-notification.c
>>>> @@ -45,6 +45,7 @@
>>>>    #define WAP_PUSH_DST_PORT 2948
>>>>
>>>>    static unsigned int modemwatch_id;
>>>> +static GHashTable *sms_watches =3D NULL;
>>>>
>>>>    struct push_notification {
>>>>        struct ofono_modem *modem;
>>>> @@ -164,6 +165,16 @@ static void push_notification_cleanup(gpointer
>>>> user)
>>>>        ofono_modem_remove_interface(pn->modem,
>>>> PUSH_NOTIFICATION_INTERFACE);
>>>>    }
>>>>
>>>> +static gboolean atom_watch_remove(gpointer key, gpointer value,
>>>> +                    gpointer user_data)
>>>> +{
>>>> +    struct ofono_modem *modem =3D key;
>>>> +
>>>> +    __ofono_modem_remove_atom_watch(modem, GPOINTER_TO_UINT(value));
>>>> +
>>>> +    return TRUE;
>>>> +}
>>>> +
>>>>    static void sms_watch(struct ofono_atom *atom,
>>>>                    enum ofono_atom_watch_condition cond,
>>>>                    void *data)
>>>> @@ -197,18 +208,22 @@ static void sms_watch(struct ofono_atom *atom,
>>>>    static void modem_watch(struct ofono_modem *modem, gboolean added,
>>>> void *user)
>>>>    {
>>>>        struct push_notification *pn;
>>>> +    int sms;
>>>>        DBG("modem: %p, added: %d", modem, added);
>>>>
>>>> -    if (added =3D=3D FALSE)
>>>> +    if (added =3D=3D FALSE) {
>>>> +        g_hash_table_remove(sms_watches, modem);
>>>>            return;
>>>> +    }
>>>
>>> This has no effect.  The atom_watches for that particular modem have
>>> already been freed by the time the modem watch has been called in
>>> call_modemwatches().  See modem_unregister for details.
>> Depends on which exit is called first, for at least some plugins the
>> exit can be called before modem_unregister. So the plugin is already
>> cleaned up when its atom watch is being called. This is the root of the
>> SIGFPE in glib.
>> This just removes the entry in the local hash table, as the plugin exit
>> function will now unregister the watches if there are any active during
>> exit.
>
> I still don't see how it matters in this case.  Even if =

> push_notification plugin is cleaned up first, all it will do is remove =

> the modemwatch.  All actual watches created will be cleaned up when =

> the modem is removed.
>
> I suspect the issue is isolated to hfp_ag_bluez5 plugin only.
>
>>>
>>>>
>>>>        pn =3D g_try_new0(struct push_notification, 1);
>>>>        if (pn =3D=3D NULL)
>>>>            return;
>>>>
>>>>        pn->modem =3D modem;
>>>> -    __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SMS,
>>>> -                    sms_watch, pn, g_free);
>>>> +    sms =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SMS,
>>>> +                        sms_watch, pn, g_free);
>>>> +    g_hash_table_insert(sms_watches, modem, GUINT_TO_POINTER(sms));
>>>>    }
>>>>
>>>>    static void call_modemwatch(struct ofono_modem *modem, void *user)
>>>> @@ -220,6 +235,8 @@ static int push_notification_init(void)
>>>>    {
>>>>        DBG("");
>>>>
>>>> +    sms_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
>>>> +
>>>>        modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, =

>>>> NULL);
>>>>
>>>>        __ofono_modem_foreach(call_modemwatch, NULL);
>>>> @@ -232,6 +249,9 @@ static void push_notification_exit(void)
>>>>        DBG("");
>>>>
>>>>        __ofono_modemwatch_remove(modemwatch_id);
>>>> +
>>>> +    g_hash_table_foreach_remove(sms_watches, atom_watch_remove, =

>>>> NULL);
>>>> +    g_hash_table_destroy(sms_watches);
>>>
>>> atom watches are already being removed by the virtue of modems being
>>> unregistered.
>>>
>>>>    }
>>>>
>>>>    OFONO_PLUGIN_DEFINE(push_notification, "Push Notification Plugin",
>>>> VERSION,
>>>>
>>>
>>> Regards,
>>> -Denis
>> I hope this clarifies the reason for this patch. I deeply apologize for
>> not including this information with the patch submission.
>>
>> Best regards // John Ernberg
>>
>
> Regards,
> -Denis
I think we can drop this patch set as it's most likely a fault on my =

part that causes the problem. If this happens to be an actual problem =

upstream under some circumstances, I will submit a new version of this set.

Best regards // John Ernberg
--===============4321209105996070398==--

