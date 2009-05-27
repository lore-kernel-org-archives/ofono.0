Content-Type: multipart/mixed; boundary="===============3809093756332042740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: two patches for voicecall.c
Date: Wed, 27 May 2009 10:03:24 -0500
Message-ID: <200905271003.25070.denkenz@gmail.com>
In-Reply-To: <61563CE63B4F854986A895DA7AD3C17709D989BF6F@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3809093756332042740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Minjun,

On Wednesday 27 May 2009 02:46:00 Li, Minjun wrote:
> Hi Folks,
> I have made 2 patches for minor bugs in functions of voicecall_busy and
> dial_callback in /src/voicecall.c. The first one is to use the function
> pointer set_udub to replace release_specific. The second one is to delete
> the repeated calling of voicecall_create in dial_callback function, since
> it was called in previous line in the same function.

Both patches have been applied upstream.  Thanks!

Regards,
-Denis

--===============3809093756332042740==--

