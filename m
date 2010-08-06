Content-Type: multipart/mixed; boundary="===============7983095546349717992=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] phonesim: Don't use VENDOR_PHONESIM for Calypso.
Date: Fri, 06 Aug 2010 12:17:58 -0500
Message-ID: <4C5C43C6.6090300@gmail.com>
In-Reply-To: <1281029457-9048-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7983095546349717992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 08/05/2010 12:30 PM, Andrzej Zaborowski wrote:
> Also move the STK initialisation to post-sim because it is more logical
> there (even if it makes no difference under phonesim).
> =

> I'm not sure if there's any user of the "calypso" mode in phonesim
> driver now, perhaps it can be removed.

Could you please do me a favor and put 'comment' paragraphs in the
git-send-email block specifically designated for this?  These are fairly
context specific questions and make no sense to be included in the
commit history.  I have to git --amend and take them out manually.

To answer your question, we use 'calypso' driver for phonesim when using
the Freerunner modem over TCP.  This way oFono can be quickly run and
tested without the need to cross-compile.  This part is still useful in
certain circumstances, so it is safe to leave it in for now...

All patches in this series have been applied.

Regards,
-Denis

--===============7983095546349717992==--

