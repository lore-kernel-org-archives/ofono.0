Content-Type: multipart/mixed; boundary="===============7415075358521050774=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: Fix AT+CHLD=1x
Date: Tue, 13 Mar 2012 21:38:47 -0500
Message-ID: <4F6004B7.8050608@gmail.com>
In-Reply-To: <1331649195-23257-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7415075358521050774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/13/2012 09:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> AT+CHLD=3D1x should only hangup active call
> ---
>  src/callmanager.cpp |   38 ++++++++++++++++++++++++--------------
>  1 files changed, 24 insertions(+), 14 deletions(-)
> =


What are you trying to fix here?  Phonesim models the behavior of an
'ideal' modem which can hangup any call using release_specific.  Plenty
of modems exhibit this behavior via vendor specific AT commands, so if
this is related to HFP emulation then we probably need to do something else.

Regards,
-Denis

--===============7415075358521050774==--

