Content-Type: multipart/mixed; boundary="===============7006301603565273540=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] n900: Use consistent naming in GPIO API
Date: Wed, 30 May 2012 00:54:23 -0500
Message-ID: <4FC5B60F.7070204@gmail.com>
In-Reply-To: <1337018591-6553-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7006301603565273540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 05/14/2012 01:03 PM, Aki Niemi wrote:
> In addition, add header guards as the API can be used from more than
> one plugin.

This part makes no sense, nokia-gpio.h is a private header and should =

not need include guards.  And in fact works just fine without them, =

please remove these.

Regards,
-Denis

--===============7006301603565273540==--

