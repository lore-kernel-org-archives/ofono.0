Content-Type: multipart/mixed; boundary="===============0632654579369240961=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 2/8] telit: add additional port for data connection
Date: Fri, 17 Aug 2012 09:53:55 +0200
Message-ID: <502DF893.6040408@hale.at>
In-Reply-To: <50293379.7090003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0632654579369240961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Gustavo,

On 13/08/12 19:03, Denis Kenzior wrote:
> Hi Christopher,
>
> CC-ing Gustavo since he wrote much of the SAP bits in this driver...
>
> On 08/13/2012 08:17 AM, Christopher Vogl wrote:
>> Use MDM port for data service and AUX for the AT chat.
>> Disable DCD so that the modem does not hangup after a data connection.
>> Add vendor for sim and gprs.
>>
>> udevng: rename aux port from Data to Aux for telit.
>>
>> Telit software user guide says:
>> USB AUX doesn=E2=80=99t support any flow control method. Therefore, this=
 port
>> isn=E2=80=99t suitable for DATA service port.
>> We recommend this port should be used only for AT command
>> and URC processing.
>> ---
>>   plugins/telit.c  |   76 =

>> +++++++++++++++++++++++++++++++++++++----------------
>>   plugins/udevng.c |    2 +-
>>   2 files changed, 54 insertions(+), 24 deletions(-)
>>
>> diff --git a/plugins/telit.c b/plugins/telit.c
>> index 853fd44..8446a22 100644
>> --- a/plugins/telit.c
>> +++ b/plugins/telit.c
>> @@ -65,8 +65,8 @@ static const char *qss_prefix[] =3D { "#QSS:", NULL };
>>   static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
>>
>>   struct telit_data {
>> -    GAtChat *chat;
>> -    GAtChat *aux;
>> +    GAtChat *chat;        /* AT chat */
>> +    GAtChat *modem;        /* Data port */
>>       struct ofono_sim *sim;
>>       struct ofono_modem *sap_modem;
>>       GIOChannel *bt_io;
>> @@ -295,6 +295,13 @@ static void cfun_enable_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>           return;
>>       }
>>
>> +    /*
>> +     * Switch data carrier detect signal off.
>> +     * When the DCD is disabled the modem does not hangup anymore
>> +     * after the data connection.
>> +     */
>> +    g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
>> +
>>       ofono_modem_set_powered(m, TRUE);
>>
>>       /* Enable sim state notification */
>> @@ -311,10 +318,19 @@ static int telit_enable(struct ofono_modem *modem)
>>
>>       DBG("%p", modem);
>>
>> -    data->chat =3D open_device(modem, "Modem", "Modem: ");
>> -    if (data->chat =3D=3D NULL)
>> +    data->modem =3D open_device(modem, "Modem", "Modem: ");
>> +    if (data->modem =3D=3D NULL)
>>           return -EINVAL;
>>
>> +    data->chat =3D open_device(modem, "Aux", "Aux: ");
>> +    if (data->chat =3D=3D NULL) {
>> +        g_at_chat_unref(data->modem);
>> +        data->modem =3D NULL;
>> +        return -EIO;
>> +    }
>> +
>> +    g_at_chat_set_slave(data->modem, data->chat);
>> +
>
> Gustavo, are you OK with these changes? I do not recall whether it =

> made a difference on which port the #RSEN was being sent.
>
>>       /*
>>        * Disable command echo and
>>        * enable the Extended Error Result Codes
>> @@ -362,8 +378,6 @@ static void rsen_enable_cb(gboolean ok, GAtResult =

>> *result, gpointer user_data)
>>       DBG("%p", modem);
>>
>>       if (!ok) {
>> -        g_at_chat_unref(data->aux);
>> -        data->aux =3D NULL;
>>           ofono_modem_set_powered(data->sap_modem, FALSE);
>>           sap_close_io(modem);
>>           return;
>> @@ -380,6 +394,21 @@ static void cfun_disable_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>
>>       DBG("%p", modem);
>>
>> +    GIOChannel *channel =3D g_at_chat_get_channel(data->modem);
>> +    if(channel) {
>> +        g_io_channel_unref(channel);
>> +        channel =3D NULL;
>> +    }
>
> Why do you need this part?  What's the reason to manually unref the =

> channel?

This is a relict of a workmate desperately trying to find out why the =

modem hangs up after a ppp connection -
which was finally solved by sending '&CO'.
Sorry, this code part does not belong here and I have to be more careful =

when sending patches.

>
>> +
>> +    g_at_chat_unref(data->modem);
>> +    data->modem =3D NULL;
>> +
>> +    channel =3D g_at_chat_get_channel(data->chat);
>> +    if(channel) {
>> +        g_io_channel_unref(channel);
>> +        channel =3D NULL;
>> +    }
>> +
>
> And here?
>
>>       g_at_chat_unref(data->chat);
>>       data->chat =3D NULL;
>>
>> @@ -394,6 +423,9 @@ static int telit_disable(struct ofono_modem *modem)
>>       struct telit_data *data =3D ofono_modem_get_data(modem);
>>       DBG("%p", modem);
>>
>> +    g_at_chat_cancel_all(data->modem);
>> +    g_at_chat_unregister_all(data->modem);
>> +
>>       g_at_chat_cancel_all(data->chat);
>>       g_at_chat_unregister_all(data->chat);
>>
>> @@ -411,9 +443,6 @@ static void rsen_disable_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>
>>       DBG("%p", modem);
>>
>> -    g_at_chat_unref(data->aux);
>> -    data->aux =3D NULL;
>> -
>>       sap_close_io(modem);
>>
>>       telit_disable(modem);
>> @@ -469,10 +498,6 @@ static int telit_sap_enable(struct ofono_modem =

>> *modem,
>>       g_io_channel_set_buffered(data->hw_io, FALSE);
>>       g_io_channel_set_close_on_unref(data->hw_io, TRUE);
>>
>> -    data->aux =3D open_device(modem, "Data", "Aux: ");
>> -    if (data->aux =3D=3D NULL)
>> -        goto error;
>> -
>>       data->bt_io =3D g_io_channel_unix_new(bt_fd);
>>       if (data->bt_io =3D=3D NULL)
>>           goto error;
>> @@ -491,13 +516,13 @@ static int telit_sap_enable(struct ofono_modem =

>> *modem,
>>
>>       data->sap_modem =3D sap_modem;
>>
>> -    g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
>> +    g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
>>                   FALSE, modem, NULL);
>>
>> -    g_at_chat_send(data->aux, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
>> +    g_at_chat_send(data->chat, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
>>
>>       /* Set SAP functionality */
>> -    g_at_chat_send(data->aux, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
>> +    g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
>>                   rsen_enable_cb, modem, NULL);
>>
>>       return -EINPROGRESS;
>> @@ -516,10 +541,7 @@ static int telit_sap_disable(struct ofono_modem =

>> *modem)
>>
>>       DBG("%p", modem);
>>
>> -    g_at_chat_cancel_all(data->aux);
>> -    g_at_chat_unregister_all(data->aux);
>> -
>
> Removing this part might not be correct, Gustavo?

telit_sap_disable() will lead to a call of rsen_disable_cb(), which in =

turn calls telit_disable().
telit_disable() includes the code removed above.

>
>>
>>   static struct ofono_modem_driver telit_driver =3D {
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index 872039a..bd5e5e0 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -615,7 +615,7 @@ static gboolean setup_telit(struct modem_info =

>> *modem)
>>       DBG("modem=3D%s aux=3D%s gps=3D%s diag=3D%s", mdm, aux, gps, diag);
>>
>>       ofono_modem_set_string(modem->modem, "Modem", mdm);
>> -    ofono_modem_set_string(modem->modem, "Data", aux);
>> +    ofono_modem_set_string(modem->modem, "Aux", aux);
>>       ofono_modem_set_string(modem->modem, "GPS", gps);
>>
>>       return TRUE;
>
>
> This part belongs in a separate patch.
>

Ok!
Corrected patches will follow.


Regards,
Christopher


--
Scanned by MailScanner.


--===============0632654579369240961==--

