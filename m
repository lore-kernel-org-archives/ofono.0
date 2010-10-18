Content-Type: multipart/mixed; boundary="===============8313211328496246086=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA SMS Handling
Date: Mon, 18 Oct 2010 17:31:58 -0500
Message-ID: <4CBCCADE.8020200@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702B1FFC5@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8313211328496246086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

>> Doing it the way I suggested would keep the impact on the current code
> base absolutely minimal. This way you can start =

>> submitting patches right away for CDMA support
>> without impacting anyone.  Once the CDMA aspects are stabilized and
> we're happy with them we can do the final struct / =

>> API refactoring as needed.
>>
>> Thoughts?
> =

> Yes, i agree doing this way would have minimal impact to the current
> code base. But from refactoring prespective the effort will be double if
> we do the refactoring at the later stage, as now we need to refactor
> only the GSM code and later we have to refactor both GSM and CDMA code.

I understand your concern, but I think the changes required are simply
too invasive at this point.  There's also the possibility that after
doing all the work for CDMA we might find that it is incompatible with
the rest of smsutil.  I prefer not to take this risk right now.

Besides, I think you will find that transforming the data structures
from my proposal to your original proposal at a later date will not be
that much work.  If we have proper unit tests in place it should take no
more than an afternoon...

Regards,
-Denis

--===============8313211328496246086==--

