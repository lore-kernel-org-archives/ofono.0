Content-Type: multipart/mixed; boundary="===============7096164262067994865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC hwdb v1 20/28] telitqmi: drop unused device rule
Date: Fri, 31 Mar 2017 17:35:33 -0500
Message-ID: <1d076a75-9217-d80e-e475-6045c4a17d23@gmail.com>
In-Reply-To: <56d262bd-2ac0-5cb7-16d8-ae287b1864ab@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7096164262067994865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/31/2017 05:37 AM, Jonas Bonn wrote:
> On 03/31/2017 10:35 AM, Lukasz Nowak wrote:
>> Hi Jonas,
>>
>> On 30/03/17 21:53, Jonas Bonn wrote:
>>> The rule might match for some device but setup_telitqmi does not attempt
>>> to do anything for interfaces that aren't driven by the qmi_wwan driver
>>> so it's pointless.
>> As I described before, this rule is not pointless, it prevents this rule:
>>        { "telit",    "option",    "1bc7"        },
>>
>> from taking over the device, and using setup_telit instead of
>> setup_telitqmi.
>>
>> Lukasz
>
> Yes, but in the context of the transition to hwdb it should not be
> necessary anymore.  That said, I see the problem and I think it still
> persists in the hwdb model.  The problem is the Telit catch-all rule; we
> really need to get rid of it but that risks rendering a bunch of modems
> that work today non-functional.  This needs some thought.
>

Why don't we unify setup_telit & setup_telitqmi and let the unified =

function figure out whether the particular telit modem is QMI based or =

not.  Similar to what setup_sierra does.

Regards,
-Denis


--===============7096164262067994865==--

