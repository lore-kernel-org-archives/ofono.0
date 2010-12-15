Content-Type: multipart/mixed; boundary="===============3786829106979013930=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] cdma-atmodem: Add CDMA MO Call Support
Date: Wed, 15 Dec 2010 13:02:32 -0600
Message-ID: <4D0910C8.3050406@gmail.com>
In-Reply-To: <1292273602.11965.46.camel@dardoyle-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3786829106979013930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/13/2010 02:53 PM, Dara Spieker-Doyle wrote:
> Hi Denis
> =

> On Fri, 2010-12-10 at 22:41 +0100, Spieker-Doyle Dara
> (Nokia-MS/SanDiego) wrote:
>> Hi Denis
>>
>> On Thu, 2010-12-09 at 09:43 +0100, ext Denis Kenzior wrote:
>>
>>>
>>>>  drivers/cdma-atmodem/atutil.c    |   45 +++++++++
>>>>  drivers/cdma-atmodem/atutil.h    |   65 +++++++++++++
>>>
>>> Are these verbatim copies of atmodem/atutil.[ch]?  If so, then there's
>>> no reason why you can't re-use those.  No need to copy them.
>>
>> No, they are not verbatim copies as e.g. error decoding is different.
>> Would you prefer we clarify this by renaming the files cdmautil.(ch)?
>>
> On second thoughts, I agree for this patch - I will correct this and
> re-use the drivers/atmodem/atutil.[ch].
> Additionally, for future feature support, I do envisage some delta with
> various AT utilities for CDMA. For example, with our current hardware,
> the AT return string can have a different format from the GSM AT command
> standard. =

> Do you have any particular preference in such cases as to whether we
> modify the e.g. gatchat sources directly to support this or whether we
> create CDMA specific functions within the cdma-atmodem driver?
> =


This has to be considered on a case by case basis.  I can't predict what
is the better approach until I see specifics.  Having said that, I
really hope that we do not need to change the gatchat sources directly.
 But if these changes makes sense then I certainly don't see a problem
in doing so.

Regards,
-Denis

--===============3786829106979013930==--

