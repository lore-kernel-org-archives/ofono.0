Content-Type: multipart/mixed; boundary="===============2606565390741254135=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/12] qmi: push request_submit into request_alloc
Date: Thu, 29 Mar 2018 10:13:51 -0500
Message-ID: <620bbaa6-875a-53ac-0522-f7f00b074fa8@gmail.com>
In-Reply-To: <20180329135801.5981-6-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2606565390741254135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/29/2018 08:57 AM, Jonas Bonn wrote:
> The same pattern, alloc and submit, is repeated for use of these
> functions.  As such, merging them is a net simplification.
> =

> With this, the return value of request_alloc can be changed from
> returning a request object to just returning a result code.
> ---
>   drivers/qmimodem/qmi.c | 47 +++++++++++++++----------------------------=
----
>   1 file changed, 15 insertions(+), 32 deletions(-)
> =


Actually I prefer these to be separate in case we decide to add any unit =

tests for QMI.

Regards,
-Denis


--===============2606565390741254135==--

