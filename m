Content-Type: multipart/mixed; boundary="===============6274113763681003424=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] gatserver: Add ATS6 command handler#2 - blank line
 removed, - keep int type because prototyping issue.
Date: Sat, 15 Jan 2011 02:25:59 +0100
Message-ID: <1295054759.3873.152.camel@aeonflux>
In-Reply-To: <1295016142-22748-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6274113763681003424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

>  gatchat/gatserver.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)

so I have the problem now that if I just use "git am" to apply your
patch, the commit message seen in "git log" looks wrong. Check for
yourself what happens here. It is the best way to see how git handles
these.

If you have a second version of the patch modify the Subject line to say
[PATCH v2].

Check the M5 coding style rule for commit messages. You need a clear
subject and short subject. If you have more details put them into a
commit body part.

For the change log or notes to the reviewer (which should not be part of
the commit message), you need to put them between --- and the diffstat.

Regards

Marcel



--===============6274113763681003424==--

