Content-Type: multipart/mixed; boundary="===============2013712142387107339=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono CF states not always correct
Date: Tue, 18 Jan 2011 15:50:48 -0600
Message-ID: <4D360B38.9030107@gmail.com>
In-Reply-To: <AANLkTinAG0XXmRQXTMuH-ES6VZ7YatP6r_UenLBEfERg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2013712142387107339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 01/18/2011 03:32 PM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2011/1/18 Denis Kenzior <denkenz@gmail.com>:
>> I think we can track the cached flag for conditional CFs independently
>> from CFU.  The question is really whether the networks allow us to
>> modify conditional CFs when CFU is active.  In my testing the answer is =
No.
> =

> You can erase (##67#) or deactivate (#67#) them.
> =


So CFB active.

Activate CFU
Query CFB -> Inactive

Deregister CFB -> OK
Query CFB -> Inactive

Register CFB -> Error

Deactivate CFU
Query CFB -> Inactive

Correct?

Jeez, who thought this stuff up.

So my thinking is that we should:
- Not update conditional cfs when cfu is active (whether via
GetProperties or mmi)
- only clear the conditional cache flag if a conditional operation is
attempted and succeeds while cfu is active
- Report conditional cfs as empty when CFU is active (and emit signals
appropriately when cfu is activated / deactivated)
- Don't bother running conditional cf queries via GetProperties if cfu
is active

Do you see any issues with this?  I'm really trying to minimize the
number of queries we have to do in the most common case (which is
activating / deactivating cfu via settings)

Regards,
-Denis

--===============2013712142387107339==--

