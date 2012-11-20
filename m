Content-Type: multipart/mixed; boundary="===============1031173352129908051=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v0 4/4] bluetooth: Fix Device PropertyChanged
Date: Tue, 20 Nov 2012 13:42:47 +0100
Message-ID: <50AB7AC7.2020306@monom.org>
In-Reply-To: <1353413539-19693-4-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1031173352129908051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 20.11.2012 13:12, Claudio Takahasi wrote:
> BlueZ PropertyChanged signal for Device objects was replaced by
> PropertiesChanged emitted on org.freedesktop.DBus.Properties interface.

Do I understand this correctly, we will not support older BlueZ after =

this change? I would expect that we support 4.x and 5.x at the same time =

for a while.

cheers,
daniel


--===============1031173352129908051==--

