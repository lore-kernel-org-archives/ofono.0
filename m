Content-Type: multipart/mixed; boundary="===============5968557908694482862=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] cdma-atmodem: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 14:39:38 -0600
Message-ID: <4D0FBF0A.1080100@gmail.com>
In-Reply-To: <1291854951-2378-4-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5968557908694482862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/08/2010 06:35 PM, Lei Yu wrote:
> ---
>  Makefile.am                    |    7 ++
>  configure.ac                   |    5 ++
>  drivers/cdma-atmodem/atmodem.c |   47 ++++++++++++
>  drivers/cdma-atmodem/atmodem.h |   23 ++++++

You need to synchronize with Dara on this one.  Both of you are sending
the same stub implementation.  I suggest submitting this as a separate
patch.  And please name it cdmamodem/cdmamodem.c & .h.  Dara has this
right actually.

>  drivers/cdma-atmodem/atutil.c  |   45 ++++++++++++
>  drivers/cdma-atmodem/atutil.h  |   64 +++++++++++++++++

As I mentioned before, please use the atutil.[ch] from atmodem directly.
 No need to create a new set of these...

>  drivers/cdma-atmodem/sms.c     |  151 ++++++++++++++++++++++++++++++++++=
++++++

And this one should be in a separate patch ;)

Regards,
-Denis

--===============5968557908694482862==--

