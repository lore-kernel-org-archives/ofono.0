Content-Type: multipart/mixed; boundary="===============7562258893021329182=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH 1/1] Fix primary context active/deactive result d-bus
 reply missing issue
Date: Thu, 12 May 2011 09:01:19 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD5A7470C7@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4DCAD5F0.1050209@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7562258893021329182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis:
> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Thursday, May 12, 2011 2:31 AM
> To: ofono(a)ofono.org
> Cc: Xu, Martin
> Subject: Re: [PATCH 1/1] Fix primary context active/deactive result d-bus=
 reply
> missing issue
> =

> Hi Martin,
> =

> On 04/27/2011 02:04 AM, martin.xu(a)intel.com wrote:
> > From: Martin Xu <martin.xu@intel.com>
> >
> > If user offline modem when the gprs_context is in enabling or disabling
> > state(activating/disactivating), the GPRS primary context activate/disa=
ctivate
> > result will not be replied to the corresponding application.
> > ---
> >  drivers/atmodem/gprs-context.c |    7 +++++++
> >  src/gprs.c                     |    5 +++++
> >  2 files changed, 12 insertions(+), 0 deletions(-)
> >
> =

> Please check commit 4714d8199aacf0ba6be777a70e01b3016ba2aa5f, this
> might
> partly fix this issue.
Thanks. :-)
The patch only fix the issue partly, we are continue to test and review the=
 code and try to find the final solution.=20

--===============7562258893021329182==--

