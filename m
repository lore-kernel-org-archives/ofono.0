Content-Type: multipart/mixed; boundary="===============2782140233036685920=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] mmsd: get delivery_report setting
Date: Mon, 16 Jul 2012 02:25:11 -0500
Message-ID: <5003C1D7.2080605@gmail.com>
In-Reply-To: <1341567147-18467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2782140233036685920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 07/06/2012 04:32 AM, Ronald Tessier wrote:
> This set of patches concerns mmsd and is related to delivery_report.
> Add delivery report flag and API (to set its value) to service.
> Get and track the delivery report setting used by oFono in the message ma=
nager
> and use it in mmsd.

Maybe I'm not seeing something, but why are we tracking the delivery =

report flag in oFono in mmsd?  I'm guessing you want to synchronize the =

two, but I do not see why you would want to?

Regards,
-Denis

--===============2782140233036685920==--

