Content-Type: multipart/mixed; boundary="===============8813497278492770038=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] radio-settings: adding UE dual mode operation property
Date: Mon, 13 May 2019 16:45:39 -0500
Message-ID: <99179b4b-013f-ae41-558d-82a6494430f7@gmail.com>
In-Reply-To: <CAKSBH7H_+b2N-+mjactBsBrMQfr+b0RD7UOyqP3UtBcXi_DrBA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8813497278492770038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 05/13/2019 03:54 AM, Giacinto Cifelli wrote:
> Hi Antara,
> =

> On Mon, May 13, 2019 at 10:46 AM Antara Borwankar
> <antara.borwankar@intel.com> wrote:
>>
>> Added two new values for TechnologyPreference property
>> as follows:
>> "umts,gsm"      Dual mode operation with UMTS
>>                  and GSM radio access whith preference
>>                  for UMTS.
>> "lte,umts"      Dual mode operation with LTE
>>                  and UMTS radio access with preference
>>                  for LTE.
> =

> It looks like an explosive list.
> First of all, there are several use cases for gsm+lte, which should
> also be added.

I think the current proposal / implementation treats these as an =

enumeration.  But in the future we should be able to expand this API to =

simply treat the values as a list, e.g. "lte,gsm" should be possible as =

well.  Along with maybe even "gsm,lte,umts", etc.

> But then there will be a 5g to the list, and all possible combinations

We do not yet support 5G, so lets cross that bridge when we come to it.

> of technologies, and most likely there should be a split for LTE, with
> normalLTE, catM and NB-IoT, and all the possible combinations thereof.
> I would prefer to have it as a vendor-specific extension, so that the
> combinations can also be controlled at the model level.

You can do that already now.  It is already possible to add whatever =

vendor API / extensions you want in the individual modem driver.

Regards,
-Denis

--===============8813497278492770038==--

