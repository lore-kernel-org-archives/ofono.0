Content-Type: multipart/mixed; boundary="===============2110783037974852923=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 1/1] Huawei E176: Mark primary and secondary device at
 ofono.rules TODO: Fix sim_add detection, add E1552 idProduct to ofono.rules
Date: Mon, 31 May 2010 19:52:58 +0300
Message-ID: <87d3wc2etx.fsf@potku.valot.fi>
In-Reply-To: <1275321124.2658.9.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2110783037974852923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hallo Marcel,

>> I personally would prefer a solution which would dynamically probe the
>> ports and choose them based on results. I believe modemmanager does
>> something like this, but I haven't looked in detail.
>
> we should do something like auto-detect at some point, but there are
> limits in it.

So what's the best option to go forward?

And related to this, can we rely on the port numbering order provided by
udev? For example, on my Huawei E1552 port 0 is the main chat port and
port 2 is the "event" port. Is it certain that port numbering will be
the same across all distributions and kernels?

-- =

Kalle Valo

--===============2110783037974852923==--

