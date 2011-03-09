Content-Type: multipart/mixed; boundary="===============8487930231983165478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat: fix to number parsing when number is omitted
Date: Wed, 09 Mar 2011 16:03:40 -0600
Message-ID: <4D77F93C.7020206@gmail.com>
In-Reply-To: <1299655650-7929-1-git-send-email-paavo.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8487930231983165478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paavo,

On 03/09/2011 01:27 AM, Paavo Leinonen wrote:
> Line position index must be updated the number field is empty. Otherwise
> we will read same field again in subsequent calls.
> ---
> =

> Hi,
> =

> While testing SIM Phonebook we noticed that Email addresses stored to SIM=
 PB
> were not properly parsed by oFono. Root cause for this was =

> g_at_result_iter_next_number which did not update iterator's line_pos
> attribute when number was missing. As a result, wrong fields were =

> read when parsing email field (among others).

This is actually on purpose, we do not want to consume the field if the
parsing failed.  For fields that might have omitted entries I suggest
you use g_at_result_iter_next_number_default.

Regards,
-Denis

--===============8487930231983165478==--

