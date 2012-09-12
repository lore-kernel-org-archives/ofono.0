Content-Type: multipart/mixed; boundary="===============7404184289766435445=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 2/2] netreg: Add telit version for ciev notification
Date: Wed, 12 Sep 2012 10:13:57 +0200
Message-ID: <50504445.1000908@hale.at>
In-Reply-To: <50500E73.1090202@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7404184289766435445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> Patch has been applied, however:
>
>> @@ -1618,6 +1649,19 @@ static void cind_support_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>                   at_cmer_query_cb, netreg, NULL);
>>       g_at_chat_register(nd->chat, "+CIEV:",
>>                   ciev_notify, FALSE, netreg, NULL);
>> +
>> +    /*
>> +     * Telit uses strings instead of numbers to identify indicators
>> +     * in a +CIEV URC.
>> +     * Handle them in a separate function to keep the code clean.
>> +     */
>> +    if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
>> +        g_at_chat_register(nd->chat, "+CIEV:",
>> +                telit_ciev_notify, FALSE, netreg, NULL);
>> +    else
>> +        g_at_chat_register(nd->chat, "+CIEV:",
>> +                ciev_notify, FALSE, netreg, NULL);
>> +
>
> You ended up registering for +CIEV twice, so I took that out in commit =

> bb0f308223816e53de0a5a6a2cdb6eb1f11856c8.

Thanks for fixing this! I missed to remove the previous code.

>
> Also, I made failing to initialize +CMER fatal in commit =

> b274e74102c7a4b96c06dba895cf0cb444fa54c3.  Can you please double-check =

> that it is working as intended, I only performed basic sanity checking =

> on my end.

I sent the CMER-string that is not supported by Telit (3,0,0,1) and the =

netreg atom gets removed after a corresponding error message (the modem =

still sets up a ppp connection afterwards):

...
Sep  12 03:39:01 mx31tt01 daemon.info ofonod[719]: Aux: > AT+CMER=3D?\r
Sep  12 03:39:01 mx31tt01 daemon.info ofonod[719]: Aux: < \r\n+CMER: =

(0-3),(0),(0),(0,2),(0)\r\n\r\nOK\r\n
Sep  12 03:39:01 mx31tt01 daemon.debug ofonod[719]: =

drivers/atmodem/network-registration.c:build_cmer_string()
Sep  12 03:39:01 mx31tt01 daemon.err ofonod[719]: +CMER not supported by =

this modem.  If this is an error please submit patches to support this =

hardware
Sep  12 03:39:01 mx31tt01 daemon.debug ofonod[719]: =

src/network.c:netreg_remove() atom: 0x17ab810
...

Regards,
Christopher

--
Scanned by MailScanner.


--===============7404184289766435445==--

