Content-Type: multipart/mixed; boundary="===============4102810432582428394=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv6 3/3] Mobile broadband provider info plugin
Date: Tue, 20 Sep 2011 16:44:21 +0300
Message-ID: <4E7898B5.2050705@intel.com>
In-Reply-To: <4E699CFB.7090500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4102810432582428394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 09/09/2011 07:58 AM, Denis Kenzior wrote:
> After reviewing this patch I got the impression that you were still
> making things just way too complicated and not taking full advantage of
> the push/pop semantics.  So just for fun I wrote my own version in
> plugins/mbpi.[ch] and reworked tools/lookup-apn to use that.  The code
> seems to be valgrind clean and can handle duplicate detection, bail out
> early, etc.
>
> Can you please take a look and suggest improvements?  Once you think it
> is good enough, I'd like you to rewrite this patch series to utilize
> mbpi.c parser.

Thanks, I have just looked. I am fine with this approach too.

One of the ideas of the implementation in PATCHv6 is to have the naming of =

tag_start() / tag_end() handlers to correspond to the actual tag names.

Can the same be achieved here? Can you please check PATCHv6 once again in o=
rder =

to check that idea?

A few cosmetic issues:

- the naming of struct gsm_data, perhaps, parser_data or provider_info woul=
d fit?
- gsm_start() could be broken down into smaller functions?
- Marcel wished the plugin naming "mobile-broadband-provider-info", even th=
ough =

it's a very long name. Shall we stick to that? I am fine with both.

Perhaps, some diagnostic output should be added too, in case anybody will n=
eed =

to troubleshoot it. For that, something like body_isprint() and ap_type_nam=
e() =

would be needed.

Are you fine with these?

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============4102810432582428394==--

