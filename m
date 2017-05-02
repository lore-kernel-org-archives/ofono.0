Content-Type: multipart/mixed; boundary="===============1803074376752056630=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v3 2/3] hfp_hf: Handle ServicesResolved signal
Date: Tue, 02 May 2017 10:29:31 +0300
Message-ID: <CABBYNZ+5FQ3PXTFnPkeQ2ugiYgo4kmv_WA04K-XAcbv-oojbGg@mail.gmail.com>
In-Reply-To: <f7a51461-d668-a412-f186-f6410394a300@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1803074376752056630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, May 1, 2017 at 6:57 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Luiz,
>
>
> On 04/28/2017 04:31 AM, Luiz Augusto von Dentz wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds handling for ServicesResolved signal which tells when BlueZ
>> is done resolving the device services so the code will no longer ignore
>> devices that got its services resolved after Paired signal.
>> ---
>>  plugins/hfp_hf_bluez5.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
>> index fb7cc3f..f7d2450 100644
>> --- a/plugins/hfp_hf_bluez5.c
>> +++ b/plugins/hfp_hf_bluez5.c
>> @@ -555,9 +555,9 @@ static struct ofono_modem
>> *modem_register_from_proxy(GDBusProxy *proxy,
>>
>>         dbus_message_iter_get_basic(&iter, &paired);
>>
>> -       if (paired =3D=3D FALSE) {
>> -               modem =3D ofono_modem_find(device_path_compare, (void *)
>> path);
>> +       modem =3D ofono_modem_find(device_path_compare, (void *) path);
>>
>> +       if (paired =3D=3D FALSE) {
>>                 if (modem !=3D NULL) {
>>                         ofono_modem_remove(modem);
>>                         g_dbus_proxy_set_removed_watch(proxy, NULL, NULL=
);
>> @@ -566,6 +566,9 @@ static struct ofono_modem
>> *modem_register_from_proxy(GDBusProxy *proxy,
>>                 return NULL;
>>         }
>>
>> +       if (modem)
>> +               return modem;
>> +
>
>
> Why would you return a non-NULL value here?  I thought your intended
> semantics (from patch 1) were to return the modem that was actually newly
> registered?

The ServiceResolved is toggled every time the device is connected
since the BlueZ attempt to update it cache, thus this checks if the
modem already exists and if it does return it.

> The new_connection code path is really quite special, so it really begs a
> comment.  I also wonder if modem_register_from_proxy should be separated
> into two functions.  One to handle the actual registration path, and one =
to
> handle the device removal.

Yep, I will split this into registration and removal.

>
>>         if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALS=
E)
>>                 return NULL;
>
>
> Can UUIDs change from having HFP AG to not having HFP AG btw?  We might be
> missing an additional remove path in that case.

It may actually remove UUIDs, so I guess we should remove the modem in
the same way we remove if not paired.

> Regards,
> -Denis



-- =

Luiz Augusto von Dentz

--===============1803074376752056630==--

