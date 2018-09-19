Content-Type: multipart/mixed; boundary="===============5871245446239069427=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 10:59:59 -0500
Message-ID: <4f122950-8bf7-af80-de18-3464c08d14dd@gmail.com>
In-Reply-To: <CAKSBH7F47veJBM_mnU2tzb+c3MoHPdiomMav7tcO4GRtgFr35w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5871245446239069427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> From the ./HACKING file I understood that the requirement is to
> split=C2=A0according to the top-level directories only, and to make sure =
not =

> to break compilation.

The rule provides a baseline minimum.  It also implies that sometimes =

breaking compilation is inevitable.  So long as the entire series is =

results in a clean build, that is fine.  Other projects are stricter =

here in order to not break 'git bisect' functionality.  But we are not.

> Definitely I will add more comments to the commits, too.

Don't be afraid to do that.  The more commits and the smaller the =

patches, the easier it is to review things.  In fact, as a rule of =

thumb, it is much faster to get 10 small patches upstream than 1 big patch.

> well, this is the interesting part of this series of patches.
> What the lte atom does is really parallel to the gprs-context, at the =

> end is a big code duplication.

I see them as related but the gprs change itself can stand on its own. =

Also much of the duplicated code can be factored out into common.c

A good rule of thumb is to ask yourself this question: "Are these =

changes useful just by themselves?"  If the answer is yes, then you =

should separate them into a distinct commit.  And this is part of the =

reason why it is easier to get upstream when it is broken down into =

smaller chunks.  Even if some part of the series is controversial, the =

other parts might not be and could easily be applied right away.

> Isn't there a smart way to reduce this?

Are you referring to the number of commits? Why would you want to?

... or code duplication?  In which case yes, you need to factor things =

out into common.c.

> =

> already fixed in the rest of this patch series. But this implies that I =

> will have to submit again a multi-part patch for this change.

Which is why a few days ago I suggested you start with a small subset to =

learn the process.  It is far easier to re-factor smaller chunks than =

3-4k of code.

> =

> this means submitting a patch for the D-Bus API before the others ?

Yes, preferably.

> In any case it has to go with the rest if it has to compile.
> I still haven't figured out completely how to split properly to ensure =

> compilation.
> =


Browse git history and see how this is done if you're not sure.  Our git =

history tends to be quite clean.  But in general, this is a practical =

skill and like anything will take some time to get comfortable with.

Regards,
-Denis

--===============5871245446239069427==--

