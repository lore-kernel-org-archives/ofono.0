Content-Type: multipart/mixed; boundary="===============1269998702629821941=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono CF states not always correct
Date: Tue, 18 Jan 2011 15:24:11 -0600
Message-ID: <4D3604FB.3010101@gmail.com>
In-Reply-To: <AANLkTinjZLt2=Od7ysOv9mwCVSVg9QCftNQnqetfDHK1@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1269998702629821941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 01/18/2011 03:08 PM, Pekka Pessi wrote:
> HI Denis,
> =

> 2011/1/18 Denis Kenzior <denkenz@gmail.com>:
>> Ok, so I'm convinced we're not handling this properly.  Based on your
>> testing and my own independent testing setting the Unconditional CF rule
>> does indeed 'hide' all other rules so they appear inactive.
>>
>> So do you care to come up with a patch fixing this?  Briefly thinking
>> about this I believe we can implement option 2 from your earlier email.
> =

> I've yet to see a network which sends forwardingFeatureList for
> conditional CFs if unconditional CF is active, they just tell that the
> unconditional CFs are, uh, quiescent.
> =

> Try your self, do you get anything sensible from *#67# if you have CFU
> active? (Like after step #4 above?)
> =


That was indeed the behavior on T-mobile during my personal testing.  So
I'm already convinced ;)

>>  I'd rather play some tricks and not clear the cache unless really
>> necessary.
> =

> I just don't see any option but clearing the cache. Of course, we can
> optimize by the fact that CFU makes  conditional CFs
> inactive/quiescent.
> =


I think we can track the cached flag for conditional CFs independently
from CFU.  The question is really whether the networks allow us to
modify conditional CFs when CFU is active.  In my testing the answer is No.

Regards,
-Denis

--===============1269998702629821941==--

