Content-Type: multipart/mixed; boundary="===============8985147561588870076=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Thu, 03 Apr 2014 19:13:05 -0500
Message-ID: <533DF911.1070806@gmail.com>
In-Reply-To: <533DF84E.9010008@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8985147561588870076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

On 04/03/2014 07:09 PM, Antti Kaijanm=C3=A4ki wrote:
> On 04.04.2014 02:45, Antti Kaijanm=C3=A4ki wrote:
>> Only if the file exists phonesim plugin would then create a _listening_
>> socket on the specified port.
> =

> Actually, are plugins able to register arbitrary dbus-objects under
> org.ofono?
> =


Yes, plugins can do whatever they wish.  See plugins/smart-messaging.c
for an example.

Regards,
-Denis



--===============8985147561588870076==--

