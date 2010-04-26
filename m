Content-Type: multipart/mixed; boundary="===============8405141516449814690=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] stkutil: Move advance of ctlv to decicated proactive
 commands parser
Date: Mon, 26 Apr 2010 10:39:20 -0500
Message-ID: <201004261039.20895.denkenz@gmail.com>
In-Reply-To: <i2nfb249edb1004260753u2ddb4067g6f136c918f9bec09@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8405141516449814690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi Yang,
> =

> On 26 April 2010 12:29, Yang Gu <yang.gu@intel.com> wrote:
> > Not all the proactive commands have comprehension tlv other than command
> > details and device identities. So the appropriate code should be moved =
to
> > decicated parser if needed.
> =

> Maybe parse_dataobj() would be a better place?

Agreed, lets not repeat this in every single command parser.

Regards,
-Denis

--===============8405141516449814690==--

