Content-Type: multipart/mixed; boundary="===============1851508944180215054=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Modem auto enable
Date: Thu, 15 Dec 2016 10:46:41 -0600
Message-ID: <c0eccb64-b572-dd5d-9438-37350af61efa@gmail.com>
In-Reply-To: <CAH4ZQwsASfZY=Za+V8UYmjrau=Gzj1OFv-sA-ooQEHA1pQgF7Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1851508944180215054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 12/15/2016 09:29 AM, Enrico Sau wrote:
> Hi all,
> I got a suggestion from a friend.
> It seems like the Ubuntu network manager sets the Powered property to
> TRUE immediately after the "modem added" signal is sent.
>

Correct.  oFono does not automatically power up the modems it detects. =

This is done by the network manager on the system.  E.g. ConnMan for =

platforms using it, or NetworkManager if built with oFono support.

Regards,
-Denis


--===============1851508944180215054==--

