Content-Type: multipart/mixed; boundary="===============2941495251890741121=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/2] stkutil: convert text attributes to html
Date: Wed, 23 Jun 2010 13:51:01 -0700
Message-ID: <20100623135101.77c607f7@kcaccard-MOBL3>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731ED8F332@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2941495251890741121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jun 2010 14:00:44 +0800
"Gu, Yang" <yang.gu@intel.com> wrote:

> =

> When you fix your current algorithm, can we think about these optimizatio=
ns at the same time?
> 1. The attribute overlapping may split the text into undesirable pieces. =
That is, we may find opportunities to merge the adjacent ones together at l=
ast. =

> 2. Some embedded attributes may be omitted. Taking your above case as exa=
mple, the second "background-color:#FFFFFF" can be omitted.
> 3. Part of attributes, not the whole, can be merged together. For example=
: <red bold>a</red bold><red italic>b</red italic> "may" (not always bring =
benefit) be optimized as <red><bold>a</bold><italic>b</italic></red>. =

> =

> The target of these optimizations is to make to generated html file as sm=
all as possible. I guess this is a NP-complete problem, and not easy to han=
dle :) =


My feeling is that we should just worry about getting the =

conversion done in the least complicated and most expedient way.  =

We could look at optimizations later if it becomes apparent that
they are needed.


--===============2941495251890741121==--

