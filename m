Content-Type: multipart/mixed; boundary="===============3169050248772037238=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv8 4/6] plugins: mobile-broadband-provider-info parser
 changes
Date: Wed, 05 Oct 2011 11:07:43 +0300
Message-ID: <4E8C104F.2090008@intel.com>
In-Reply-To: <4E8B128D.5060203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3169050248772037238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 10/04/2011 05:05 PM, Denis Kenzior wrote:
> While you're strictly right, in practice this is not something to worry
> about.  Our convention is to ignore the possibility of failure on small
> allocations, these can't really happen on Linux anyway.  The OOM killer
> will kill something before that happens, likely a system daemon that is
> even more important than oFono ;)
>
> As a rule of thumb the only time you should worry about memory
> allocations is when you're allocating more than a few pages worth of
> memory.

OK. Thanks for the clarification, I will follow this approach.

>> In case there are multiple "name", "username", "password" entries per
>> APN. In theory this can't happen with the proper validation of the
>> database, in practice users can edit it manually and use without the
>> validation, which would result in the memory leak. Does this make sense?
>
> I don't think it does, no user should be able to edit the provisioning
> database.  oFono is running as root and expects this to be readable by
> root only.  If you really want to handle this case then returning an
> error (since that is what it is) would be way better.

OK, let's stick to the original approach here.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============3169050248772037238==--

