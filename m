Content-Type: multipart/mixed; boundary="===============7012377207286734150=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 7/8] call-forwarding: Clear the conditional cache flag
Date: Thu, 23 Feb 2012 11:52:04 +0200
Message-ID: <4F460C44.2000004@intel.com>
In-Reply-To: <4F44EE9B.8000407@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7012377207286734150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 02/22/2012 03:33 PM, Denis Kenzior wrote:
> This would cause us to re-query everything, which is a bit wasteful.
> Also, you have to handle the same action that might occur during
> supplementary services path, e.g. the user might deactivate / erase a
> conditional service there (see cf_ss_control and
> cf_ss_control_callback).  The DisableAll path also needs to be handled
> properly.
>
> Also, there is another path you need to take under consideration and
> that is the supplementary service interrogation path.  That one can
> update conditional settings erroneously if CFU is active.  See
> ss_set_query_cf_callback.
>
> We might need to track CFU and conditional caches separately to make
> things easier.  Let me know if you have any questions.  CallForwarding
> was one of the earliest implemented interfaces and turned out to be
> quite a bit more complicated than originally thought ;)

Thanks for the help and ideas here. Let me check the supplementary services=
 path =

and how to deal with the caching. I will prepare patches to address these.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============7012377207286734150==--

