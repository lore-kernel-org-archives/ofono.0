Content-Type: multipart/mixed; boundary="===============7572772826973997525=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] AGPS Support
Date: Fri, 22 Oct 2010 10:57:22 -0500
Message-ID: <4CC1B462.7040409@gmail.com>
In-Reply-To: <81C3A93C17462B4BBD7E272753C105791945944934@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7572772826973997525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> The 27.007 Spec specifies positioning request/responses for AT where
> Positioning data are coded in XML data structures.
> =

> I think the oFono interface should not use binary data, but rather be ali=
gned with 27.007
> and present decoded data as DBUS typed signals and methods with the same =
information =

> content as specified in the XML data for AT+CPOS, AT+CPOSR.

This was proposed several times.  The main objections against the XML
file format was the difficulty of parsing such a beast and support of it
by modem vendors.

Personally (and this is based on rather limited experience with this
area) I'm not against the idea; it fits with oFono's overall strategy of
following 27.007 whenever possible...

Regards,
-Denis

--===============7572772826973997525==--

