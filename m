Content-Type: multipart/mixed; boundary="===============9017727734264383979=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: add LTE state for AT+CREG
Date: Mon, 10 Sep 2018 13:41:04 -0500
Message-ID: <7684c5c6-1746-e7b0-64ab-bc3efb80d692@gmail.com>
In-Reply-To: <bff18af6-efd5-2b1d-34bb-984918e313a5@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9017727734264383979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 09/10/2018 01:26 PM, Slava Monich wrote:
> Hi Anirudh, Denis at al.
> =

>> @@ -669,6 +669,10 @@ const char *registration_status_to_string(int =

>> status)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "unknown";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_ROAMING:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "roaming";
>>> +=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_REGISTERED_EUTRAN:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "registered lte";
>>> +=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_ROAMING_EUTRAN:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "roaming lte";
> =

> What's would be the difference between "roaming lte" and "roaming" (or =

> "registered lte" vs "registered") from the viewpoint of D-Bus API =

> clients? In other words, what would e.g. dialer do differently depending =

> on whether registration status is "registered lte" or just "registered"? =

> Is it worth the API break? The existing clients won't know how to handle =

> the new values until they (clients) get updated.
> =


I agree.  That is why I suggested a separate Property for this (and the =

CSFB case from 27.007) instead of modifying the Status property directly.

E.g. REGISTERED_SMS_EUTRAN would map to Status=3D"registered" and =

SmsOnly=3DFalse.  ROAMING_SMS_EUTRAN would map to Status=3D"roaming" and =

SmsOnly=3DTrue.

I assume that the Dialer can ignore this as the modem will fall back to =

3G in case of a call?  Someone feel free to educate me.

Regards,
-Denis

--===============9017727734264383979==--

