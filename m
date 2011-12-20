Content-Type: multipart/mixed; boundary="===============5992800916692367394=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/3] network: Add CPHS SPN, short-SPN fallbacks
Date: Tue, 20 Dec 2011 09:32:47 -0600
Message-ID: <4EF0AA9F.1060806@gmail.com>
In-Reply-To: <4EF08B5A.2060005@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5992800916692367394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 12/20/2011 07:19 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 12/20/2011 08:34 AM, Denis Kenzior wrote:
>> You have to be careful here since you can't really guarantee that the
>> operation will succeed in your time allotted.  If you are unlucky the
>> timer will fire before the entire transaction succeeds and you might be
>> running the old transaction and the new transaction in parallel.  You
>> would have to check if the current code can handle this, but probably
>> not.  And of course you never know what timer value is large enough.
> =

> Just a little more explanation here. The g_timeout_add() is periodical,
> in unlucky case it will run a few times checking whether the SPN reading
> flag is cleared and only after that will trigger the new read operation
> and unregister itself. Since we clear the flag in all SPN read callbacks
> in all cases, this should be safe.
> =


Yep, you're right I missed this in the original review.  Your proposed
approach should work just fine, but I'd still prefer something without
timeouts if possible.

>> A better approach might be to set another flag in this case, e.g.
>> RECHECK_SPN, and re-do the transaction.  However, you'd also need to
>> make sure the sim file cache is flushed as well.
> =

> This might be more efficient, let me check this.
> =


Another, third approach that might work is for the atom to keep track of
any transactions in progress and cancel them when the refresh is
detected.  They can then immediately re-initiate the new transaction
without waiting.

Regardless of which solution we pick, the trickiest part here is to make
this automatic and easy for all the EFs that we read; and there are
quite a bit of those.

>>> I will be sending SPN changes for src/gprs.c soon.
>>
>> Before you do this, a sanity check on whether any MVNOs actually use the
>> CPHS SPN field might be in order.  It may be that this complexity is not
>> needed in the gprs.c provisioning logic; and that the EFspn field is
>> sufficient.
> =

> Sure, that makes sense. I haven't found anything on usage of CPHS SPN by
> MVNOs. However, that doesn't mean nobody is using it. Anyway, that
> change won't touch the provisioning logic, might this be useful, the
> patch is almost ready, just decide when you see it.
> =


Sounds good.

Regards,
-Denis

--===============5992800916692367394==--

