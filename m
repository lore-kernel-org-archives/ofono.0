Content-Type: multipart/mixed; boundary="===============3152335132499455988=="
MIME-Version: 1.0
From: cantabile <cantabile.desu@gmail.com>
Subject: Re: Crash in sim_query_fac_pinlock_cb
Date: Wed, 31 May 2017 12:02:48 +0300
Message-ID: <2280f924-96f4-5efc-bab3-570c49b7f572@gmail.com>
In-Reply-To: <c60061de-4df4-fd9f-3af7-fd3a87ab828c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3152335132499455988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 02:12 AM, Denis Kenzior wrote:
> It is quite obvious the driver implementation is wrong.  Someone was a =

> bit too copy-paste happy.  When this driver was submitted, the query API =

> was not being exercised, hence this path was never tested.
> =

> I do not know/have the ISI specs, nor do I have any functional ISI =

> hardware.  In effect, the ISI driver code is not maintained.  If you =

> want to fix this, then you will need to figure out what the callback =

> implementation should look like.  Perhaps this RFC version of the =

> current driver code might be of use, see sec_code_state_resp_cb() in =

> particular:
> https://lists.ofono.org/pipermail/ofono/2010-October/005154.html
> =

> Regards,
> -Denis

I'm not inclined to find out what any of this is, so it'll just stay broken.

--===============3152335132499455988==--

