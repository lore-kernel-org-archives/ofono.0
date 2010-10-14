Content-Type: multipart/mixed; boundary="===============6093143546972657250=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH v2 0/3] Patch Description
Date: Thu, 14 Oct 2010 19:17:56 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473301905B3@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4CB61452.7020200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6093143546972657250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>> Then we set the path of script and run the script with its name
>> dbus-send --system --print-reply --dest=3Dorg.phonesim /
>org.phonesim.Script.SetPath string:/tmp/call
>> dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Sc=
ript.Run
>string:call.js
>>
>
>One of the changes I made was to have phonesim register to the system
>bus.  This makes the above DBus configuration file unnecessary.  Running
>phonesim on the system bus was too much of a security risk, and wasn't
>really needed.
>

Thanks for the modifications afterward, and I'm fine with most of them. One=
 question is why you renamed the service name to "org.ofono.phonesim". I wo=
nder why the phonesim should have relationship with ofono?


Regards,
-Yang

--===============6093143546972657250==--

