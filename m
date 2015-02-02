Content-Type: multipart/mixed; boundary="===============0448237789010171583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Init handsfree audio manager only for Bluez5
Date: Mon, 02 Feb 2015 09:30:20 -0600
Message-ID: <54CF980C.80508@gmail.com>
In-Reply-To: <1422880986-11262-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0448237789010171583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/02/2015 06:43 AM, Tommi Kenakkala wrote:
> Ofono should initialise Bluetooth handsfree SCO audio socket only
> with Bluez5, not with Bluez4.
> Here's one approach to work around the problem. Feel free to improve.
>
> Tommi Kenakkala (2):
>    main: Remove handsfree audio manager init and cleanup
>    handsfree-audio: Init and cleanup audio manager on ref/unref calls
>
>   src/handsfree-audio.c |   16 ++++++++--------
>   src/main.c            |    4 ----
>   2 files changed, 8 insertions(+), 12 deletions(-)
>

Looks good to me.  Applied after tweaking the commit messages.

Regards,
-Denis

--===============0448237789010171583==--

