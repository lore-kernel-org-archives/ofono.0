Content-Type: multipart/mixed; boundary="===============1286080048633253783=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 12/30] qmi: replace GQueues for requests
Date: Wed, 28 Mar 2018 15:16:09 -0500
Message-ID: <c11dd97f-ffe9-e57c-0ba9-ba1c5e1f1b5d@gmail.com>
In-Reply-To: <20180328190016.28509-13-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1286080048633253783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/28/2018 01:59 PM, Jonas Bonn wrote:
> This brings in list.h from the Linux kernel and replaces the GQueues
> used for enqueuing requests with struct list_heads.  These list
> operations are both more efficient and generally easier to work with.

In general I agree, but do they really have any significant advantages =

for our use cases?  Its not like we maintain items on multiple lists...

> Since ofono and Linux share a common license, this code borrowing should
> not be problematic in any way.

While there's no problem with the license, I really don't want QMI to =

look completely alien to the rest of the code base.  We use GLib style =

lists everywhere, so I'm really hesitant to go this way.  I think I'd =

rather we stuck to that (or switch to ell) for code maintenance & =

readability reasons.

Regards,
-Denis

--===============1286080048633253783==--

