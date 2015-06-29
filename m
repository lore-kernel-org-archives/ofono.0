Content-Type: multipart/mixed; boundary="===============4778598837462924507=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Mon, 29 Jun 2015 13:16:16 +0200
Message-ID: <55912900.6090902@hale.at>
In-Reply-To: <558BFCAF.4070700@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4778598837462924507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Am 2015-06-25 um 15:05 schrieb Marko Sulejic:
> Hi again,
>
> the problem seems to be in the
> atmodem/gprs-context.c : gprs_activate_primary
> function, where
>
>     if (g_at_chat_send(gcd->chat, buf, none_prefix,
>                 at_cgdcont_cb, gc, NULL) > 0)
>
> is called after a reconnect, and then it fails.
>
>
> It seems to work if I call
>
>     g_at_chat_send(gcd->chat, "AT&C0", none_prefix,
>                 NULL, NULL, NULL)
>
> prior.
>
> So this would mean that a disconnect or similar action sets DCD to low,
> and the chats are closed.
>
> Does oFono anywhere in the code sets DCD explicitely to low or is it =

> maybe a bug?
>
> My patch would look something like this (if it is an HE910 issue only):
>
>     if (gcd->vendor =3D=3D OFONO_VENDOR_TELIT)
>     {
>         if(g_at_chat_send(gcd->chat, "AT&C0", none_prefix,
>                     NULL, NULL, NULL) <=3D 0)
>             goto error;
>     }
>
>
> Thanks,
> Marko
>
>
> Am 2015-06-25 um 11:15 schrieb Marko Sulejic:
>> Hi,
>>
>> I need your help in using a Telit HE910 with ofono (and eventually =

>> connman).
>> (I am using ofono 1.16 with HE910 firmware version 12.00.006; connman =

>> version is 1.29).
>>
>> My problem is the following ...
>> on startup everything works fine and the ppp0 connection is established,
>> but problems occur in the following case:
>>
>> connmanctl> disconnect cellular_*_context15
>> Disconnected cellular_*_context15
>>
>> connmanctl> connect cellular_*_context15
>> Error /net/connman/service/cellular_*_context15: Input/output error
>>
>>
>> ofonod[5355]: gprs-context.c(244):at_gprs_activate_primary() cid 1
>> ofonod[5355]: gprs.c(889):pri_activate_callback() 0x1a18c50
>> ofonod[5355]: gprs.c(893):pri_activate_callback() Activating context =

>> failed with error: Unknown error type
>> connmand[3815]: Failed to change property: /he910_0/context15 =

>> org.ofono.ConnectionContext.Active: org.ofono.Error.Failed Operation =

>> failed
>>
>>
>> The same error happens if I am manually sending connect/disconnect =

>> via dbus-send.
>>
>> Only a hard ofono restart can establish the connection again.
>> This behavior happens all the time once a ppp0 disconnect happened
>> (e.g. by removing the SIM; manual disconnect via dbus or connmanctl).
>>
>> A subquestion regarding connman:
>> Can connmand be configured in such a way that on every connection
>> loss, ofono is triggered to reconnect to the Internet?
>>
>> Thank you very muchin advance,
>> Marko
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


Hi,

ok, the above code doesn't seem to solve the problem.

Regards,
Marko






--===============4778598837462924507==--

