Content-Type: multipart/mixed; boundary="===============8779597135639414823=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: how to handle ofono_netreg_status_notify() without valid LAC or
 cellid or status
Date: Thu, 07 Sep 2017 16:23:28 -0500
Message-ID: <9c82dc64-7fb2-d898-19af-e0e230166301@gmail.com>
In-Reply-To: <20170907224900.1cf64d44@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8779597135639414823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/07/2017 03:49 PM, Alexander Couzens wrote:
> Hi,
> =

> I've noticed when using a Quectel EC20 (qmimodem) sometimes I see a LAC
> and a cellid, sometimes I do not.
> After looking into it, the problems lies in the ofono plugin api or in
> the qmimodem driver. I'm unsure where I should fix this issue.
> =

> The problem:
> =

> The qmimodem notifies ofono about any change of lac, ci, tech or status.
> But the qmimodem will only include those items which have been
> changed, not all. But ofono doesn't allow only to update one single
> item, only all of them at the same time.
>   =

> void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
>                          int lac, int ci, int tech)
> If lac or ci is `-1` it seems to mean invalid (TODO: create a define or
> enum)
> =

> So how to fix this?
> =

> a) when something change, do another call to get all values from the
> modem
> =


That sounds expensive, why do you want to incur extra round-trips?

> b) extend the ofono api to allow `#define NO_CHANGE -2` for lac ci
> tech, status

Eww, please don't ;)  FYI, we long time ago decided to base the driver =

API on what is mandated by 27.007.  In the case where things are skipped =

by 27.007 we improvise.  However, in this case all the parameters are =

updated via +CREG, so I don't really want to introduce new semantics. =

The driver has to handle this.

> =

> c) unlikely: buffer the old values in the driver/qmimodem code

This sounds best so far.  What don't you like about this approach?

Regards,
-Denis

--===============8779597135639414823==--

