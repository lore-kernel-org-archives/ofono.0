Content-Type: multipart/mixed; boundary="===============3400066392332239136=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Wed, 12 Dec 2018 11:12:21 +0100
Message-ID: <CAKSBH7HVvHBwLAyTo_a15n7-8XqmY+igK9pA0z7A-GcwxMcJsg@mail.gmail.com>
In-Reply-To: <20181212100443.GB13437@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3400066392332239136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 11:04 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-12-12 08:59:34, Giacinto Cifelli wrote:
> > No, absolutely not!
> > It is forbidden to do this by the 3GPP!
>
> Checking if 3GPP is allowed to make laws in this country.... no.
>
> :-)
>
> I'm not sure if it makes sense by default, but... I don't think 3GPP
> has or should have power over ofono project.

the user owns the pin, not ofono, and can decide to disable it -
that's the mechanism.
Besides, patching in ofono modem bugs is not the way: fix the bugs instead.

3GPP is constituted by operators and countries, who have also devised
lots of certifications.
If ofono goes against these, then it cannot be used in any
3GPP-compliant network.

>                                                                 Pavel

Rgds,
Giacinto

>
>
> > On Wed, Dec 12, 2018 at 7:46 AM Nandini Rebello
> > <nandini.rebello@intel.com> wrote:
> > >
> > > Adding SIM PIN caching feature to oFono. oFono now caches the SIM PIN=
1 type
> > > against the ICCID throughout its lifetime in a link list and enters
> > > implicitly upon modem reset/crash.
> > >
> > > Handles cases of incorrect pin and sim pin changed externally.
> > >
> > > Adding to all modems by default.

--===============3400066392332239136==--

