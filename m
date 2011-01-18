Content-Type: multipart/mixed; boundary="===============5870403301437459335=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3] gatserver: ATS6 command handler added
Date: Tue, 18 Jan 2011 16:11:50 +0100
Message-ID: <1295363510.3873.205.camel@aeonflux>
In-Reply-To: <1295263138-13265-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5870403301437459335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

> Use integer to be compliant with existing function prototypes.

patch has been applied, but I did remove this comment from the commit
message. If you see it within git log it made no sense and was only
relevant for the review.

> ---

So such a comment for review belongs between --- and the diffstat.

>  gatchat/gatserver.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)

Regards

Marcel



--===============5870403301437459335==--

