Content-Type: multipart/mixed; boundary="===============2483970651180845494=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCH v1 0/2] huawei: fix cold start
Date: Fri, 17 Sep 2010 16:07:09 +0300
Message-ID: <871v8secxu.fsf@potku.valot.fi>
In-Reply-To: <20100917101755.8517.58836.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2483970651180845494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kalle.valo@canonical.com> writes:

> I finally was able to start look at Huawei again. Like reported multiple
> times, huawei currently works in only in the "warm start" case (ie. plug =
in =

> modem and restart ofono). This is a regression, this worked ok a month ag=
o.
>
> Here's currently what I have, but pin locked sims still don't work. I'll
> send the patches as RFC anyway. Please test and give feedback.

Actually my locked sim problem was just user error, I was using
unlock-pin instead of enter-pin. Oops :) So pin locked sim is now
working with huawei.

So now I need to just figure out how handle the online failure case:

+			/* FIXME: how to handle failure? */
+			/* CALLBACK_WITH_FAILURE(cb, cbd->data); */

-- =

Kalle Valo

--===============2483970651180845494==--

