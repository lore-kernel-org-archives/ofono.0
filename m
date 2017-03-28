Content-Type: multipart/mixed; boundary="===============7300812535358233247=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Missing udev rules
Date: Tue, 28 Mar 2017 10:27:26 -0500
Message-ID: <44dbc650-8bc2-acf3-4544-6389e38c0a5e@gmail.com>
In-Reply-To: <422ed278-1d3e-73d6-8d73-4321a2deb0df@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7300812535358233247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/28/2017 08:31 AM, Jonas Bonn wrote:
> Hi,
>
> I've been poking at the udevng/udev modules a bit recently.  There are
> many places where references are made to settings that come from udev
> but for which are there are no corresponding udev rules anywhere in the
> source code tree.
>
> i)  Almost all the setup_*() functions reference device node labels but
> there are almost no rules that set these labels anywhere.
> ii)  There are references to some environment variables from udev that
> aren't set in ofono rules.

These are highly platform specific.  Some we have attempted to document =

inside doc/ (e.g. see calypso-modem.txt, sim900-modem.txt, etc)  while =

for others you just need to look at how the modem driver works (e.g. ifx.c).

>
> Not knowing whether these rules actually exist in the wild means that
> it's difficult to just clean this up.  Unfortunately,
> I suspect that most of the device labelling rules are non-existant and
> that the code looks like it does because these functions get
> cut-and-pasted everytime support for a new device is added.
>

No, that's not really true.  However, nobody has touched udev plugin for =

quite some time.  One reason is that there's simply never been any need =

to do so.  Its only used for serial devices and to pass platform =

specific settings on to the modem driver.

> I think, as a general matter of policy, that any reference to a setting
> from udev needs to be accompanied by a rule that makes the setting.  If
> there's no rule, we can assume it's unused and make the according cleanup=
s.
>

I agree with the sentiment, but the reality is different.  It is best if =

we documented these in doc/foo-modem.txt as much as possible.

Regards,
-Denis


--===============7300812535358233247==--

