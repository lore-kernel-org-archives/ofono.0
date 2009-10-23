Content-Type: multipart/mixed; boundary="===============6531057620146153502=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Handle right bracket in
 g_at_result_iter_next_unquoted_string
Date: Fri, 23 Oct 2009 13:40:27 -0500
Message-ID: <200910231340.27970.denkenz@gmail.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089B872473@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6531057620146153502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Allow g_at_result_iter_next_unquoted_string to handle the bracket when
> parsing string like chld (1, 2). Original, it returns '1' and '2)'. Now it
> returns '1' and '2'. g_at_result_iter_close_list handles the right bracket
> later. ---

Patch has been applied.  Thanks.

Regards,
-Denis



--===============6531057620146153502==--

