Content-Type: multipart/mixed; boundary="===============4720918591121667684=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Fri, 04 Apr 2014 03:09:50 +0300
Message-ID: <533DF84E.9010008@canonical.com>
In-Reply-To: <533DF28E.9080209@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4720918591121667684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04.04.2014 02:45, Antti Kaijanm=C3=A4ki wrote:
> Only if the file exists phonesim plugin would then create a _listening_
> socket on the specified port.

Actually, are plugins able to register arbitrary dbus-objects under
org.ofono?

Something like /phonesim with an org.ofono.phonesim.Control interface
would be much nicer and would save the trouble of writing custom socket
communication to a root service.


--===============4720918591121667684==--

