Content-Type: multipart/mixed; boundary="===============7204138520513223287=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono CF states not always correct
Date: Wed, 26 Jan 2011 13:10:10 -0600
Message-ID: <4D407192.8040303@gmail.com>
In-Reply-To: <1296033282.2720.23.camel@poutijar-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7204138520513223287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 01/26/2011 03:14 AM, Jarko Poutiainen wrote:
> Hi Denis,
> =

> First sorry for slow reply.
> =

> On Tue, 2011-01-18 at 23:50 +0200, Denis Kenzior wrote:
>>
>> So my thinking is that we should:
>> - Not update conditional cfs when cfu is active (whether via
>> GetProperties or mmi)
>> - only clear the conditional cache flag if a conditional operation is
>> attempted and succeeds while cfu is active
>> - Report conditional cfs as empty when CFU is active (and emit signals
>> appropriately when cfu is activated / deactivated)
>> - Don't bother running conditional cf queries via GetProperties if cfu
>> is active
>>
>> Do you see any issues with this?  I'm really trying to minimize the
>> number of queries we have to do in the most common case (which is
>> activating / deactivating cfu via settings)
> =

> So:
> - Check if CFU is active and if so return empty string to any
> conditional query regardless of the the actual state and regardless of
> the used API.
> - If CFU not active return the state of queried conditional
> - If CFU active and there's an attempt to activate/deactivate
> conditional make the operation to modem/network and return possible
> error code but do not update conditional state in ofono OR if the
> attempt is successful then clear the conditional cache flag.
> =

> did I get this right?
> =


Yep, sounds right.

> and to your earlier question regarding if I could make the patch
> unfortunately I don't think I have got the time at the moment so should
> I maybe make a TODO out of this so that it won't be forgotten?
> =


That works.  Or alternatively file a bug in Meego bugzilla, but since
this is a major change it probably belongs in the TODO.

Regards,
-Denis

--===============7204138520513223287==--

