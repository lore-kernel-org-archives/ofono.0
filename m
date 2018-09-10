Content-Type: multipart/mixed; boundary="===============4504567919200860377=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] atmodem: add LTE state for AT+CREG
Date: Mon, 10 Sep 2018 21:26:46 +0300
Message-ID: <bff18af6-efd5-2b1d-34bb-984918e313a5@jolla.com>
In-Reply-To: <23e0fa81-a354-ce26-b2ed-0b8a36aac630@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4504567919200860377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh, Denis at al.

> @@ -669,6 +669,10 @@ const char *registration_status_to_string(int =

> status)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "unknown";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_ROAMING:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "roaming";
>> +=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_REGISTERED_EUTRAN:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "registered lte";
>> +=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_ROAMING_EUTRAN:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "roaming lte";

What's would be the difference between "roaming lte" and "roaming" (or =

"registered lte" vs "registered") from the viewpoint of D-Bus API =

clients? In other words, what would e.g. dialer do differently depending =

on whether registration status is "registered lte" or just "registered"? =

Is it worth the API break? The existing clients won't know how to handle =

the new values until they (clients) get updated.

Cheers,
-Slava

--===============4504567919200860377==--

