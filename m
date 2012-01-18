Content-Type: multipart/mixed; boundary="===============6447831473619254386=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 0/6] Provider name and SID
Date: Wed, 18 Jan 2012 18:32:40 +0100
Message-ID: <1326907960.6454.396.camel@aeonflux>
In-Reply-To: <1326906317-11601-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6447831473619254386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> This version introduces a QCDM helper library.
> Also, to simplify the QCDM handling, a dedicated callback is set for each
> command sent.
> Currently, we are not considering that a new command can be issued before=
 the
> answer from the previous command is handled. If this case occurs, then we=
 would
> need to introduce a command queue in the GAtHDLC structure to be able to =
invoke
> properly the callbacks.

I would actually prefer if you create a clean GAtQCDM with proper queue
handling and a clean API. Command queue inside GAtHDLC is wrong since
that is not what HDLC actually is about.

Regards

Marcel



--===============6447831473619254386==--

