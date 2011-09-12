Content-Type: multipart/mixed; boundary="===============1492971768957523307=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv6 3/3] Mobile broadband provider info plugin
Date: Mon, 12 Sep 2011 03:37:11 -0500
Message-ID: <4E6DC4B7.5000601@gmail.com>
In-Reply-To: <4E7898B5.2050705@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1492971768957523307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 09/20/2011 08:44 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 09/09/2011 07:58 AM, Denis Kenzior wrote:
>> After reviewing this patch I got the impression that you were still
>> making things just way too complicated and not taking full advantage of
>> the push/pop semantics.  So just for fun I wrote my own version in
>> plugins/mbpi.[ch] and reworked tools/lookup-apn to use that.  The code
>> seems to be valgrind clean and can handle duplicate detection, bail out
>> early, etc.
>>
>> Can you please take a look and suggest improvements?  Once you think it
>> is good enough, I'd like you to rewrite this patch series to utilize
>> mbpi.c parser.
> =

> Thanks, I have just looked. I am fine with this approach too.
> =

> One of the ideas of the implementation in PATCHv6 is to have the naming
> of tag_start() / tag_end() handlers to correspond to the actual tag names.
> =

> Can the same be achieved here? Can you please check PATCHv6 once again
> in order to check that idea?
> =


Nope, I don't think so.  The parser recursion only works when you parsed
the starting tag + any attributes, so you can't really use the subparser
idea in this way (e.g. network-id is particularly tricky).

The way I think about this is that the foo_start / foo_end handle all
elements that can be contained in <foo></foo>

> A few cosmetic issues:
> =

> - the naming of struct gsm_data, perhaps, parser_data or provider_info
> would fit?

I did think about this, but I wanted to convey the fact that we're
provisioning gsm providers only (e.g. contained in gsm tag).  However, I
really don't care here.

> - gsm_start() could be broken down into smaller functions?

Sure, this would partly accomplish your tag naming goal above.

> - Marcel wished the plugin naming "mobile-broadband-provider-info", even
> though it's a very long name. Shall we stick to that? I am fine with both.
> =


Naming the plugin provision.c would be better.  The full name is too long.

> Perhaps, some diagnostic output should be added too, in case anybody
> will need to troubleshoot it. For that, something like body_isprint()
> and ap_type_name() would be needed.
> =


You shouldn't need body_isprint unless you're doing something terribly
wrong.  The XML parser already ensures that the contents are valid UTF8.

> Are you fine with these?

Also, you might find that adding debugging might be tricky since this
code is intended to be used both from the plugin and the lookup-apn
tool.  I was too lazy to hook this up, but if you feel strongly about
it, then go ahead and add this.

Regards,
-Denis

--===============1492971768957523307==--

