Content-Type: multipart/mixed; boundary="===============0637865948820530601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] stk: Add SimApplication interface.
Date: Wed, 23 Jun 2010 16:25:47 -0500
Message-ID: <201006231625.47624.denkenz@gmail.com>
In-Reply-To: <1277205651-29369-4-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0637865948820530601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  include/dbus.h |    1 +
>  src/stk.c      |  585
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++- 2 files =

changed,
>  585 insertions(+), 1 deletions(-)
> =


Just a general comment: In the previous version of the patch you included a=
n =

api document in the commit description.  It might be a good idea to formali=
ze =

it into a proper doc/stk-api.txt document and include it along with the pat=
ch.  =

This way people have a much easier time understanding what is going on, and=
 we =

do want feedback on the API from many people for this one.

Another suggestion I have is to split out the Select Item proactive command =

handling from the regular Menu.  Perhaps moving Select Item handling to an =

Agent interface along with Display Text, Play Tone, Get Input, Get Inkey, e=
tc =

might be a good idea.

Also, I really encourage you to split this patch apart some more.  E.g. one =

patch for foundation of the stk atom, one part handling the Setup Menu / Me=
nu =

Selection envelope, another for Select Item, etc.  This makes it easier to =

review the code.  Smaller patches are always good, and higher chance that l=
ess =

controversial chunks will get accepted, leading to even smaller patches in =
the =

future.

Regards,
-Denis

Regards,
-Denis

--===============0637865948820530601==--

