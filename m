Content-Type: multipart/mixed; boundary="===============5853666323915219121=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: SAT support in oFono
Date: Fri, 21 Jan 2011 16:36:52 +0100
Message-ID: <AANLkTimi9CCephSedQYLNQoisqNbTudH8q43JSwvWo4p@mail.gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802DA0839@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5853666323915219121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka, Lasse,

On 21 January 2011 10:12,  <Jeevaka.Badrappan@elektrobit.com> wrote:
> ofono-bounces(a)ofono.org wrote:
>> Hi
>>
>> I am checking what is the level of SAT/STK support in ofono
>> and have a couple of questions. The current implementation
>> contains support for basic STK commands, like menus, inputs,
>> calls, sms and so on. In TODO, there is only REFRESH command
>> on the list.
>>
>> Is there plans or ideas to extend the support in oFono Core
>> with more complex STK features like (3GPP TS 31.111):
>> - Call control by USIM
>> - MO SMS Control by USIM
>
> Most of the modems support call control, MO SMS control on the firmware
> side itself.
> Open for adding support in ofono.
>
>> - BIP (Bearer independent protocol), including commands like
>> OPEN CHANNEL, CLOSE CHANNEL, SEND/RECEIVE DATA
>
> Inorder to support class e fully, changes are required in connman and
> ofono.
> Since class e is an optional one, I dont think we need to support this
> inorder to get GCF certified.
>
> for your question, is there any plan to support this in oFono core,
> I would leave it to Denis, Andre and Marcel to comment on this.

Currently the plan was to leave these BIP-related commands out, as
Jeevaka says they would require connman support and we didn't have a
particular use case.  Do you have practical uses for supporting these
commands in oFono core?  Same question for the call control and better
ProvideLocalInfo support (which Local Info types?).

Best regards

--===============5853666323915219121==--

