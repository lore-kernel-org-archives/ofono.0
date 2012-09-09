Content-Type: multipart/mixed; boundary="===============3937639630512735852=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC v1] gatchat: Print error message if opening tun failes
Date: Sun, 09 Sep 2012 21:41:00 +0200
Message-ID: <504CF0CC.8020806@monom.org>
In-Reply-To: <503FE419.3050908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3937639630512735852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/31/2012 12:07 AM, Denis Kenzior wrote:
> On 08/24/2012 07:16 AM, Daniel Wagner wrote:
>> From: Daniel Wagner<daniel.wagner@bmw-carit.de>
>>
>> This is a very common misstake. Let's help the users to
>> configure their system correctly.
>> ---
>> Hi,
>>
>> I was not able to find out why the check in at_grps_context_prope() =

>> does not
>> hit when the tun module is not loaded. Therefore, this on gets only
>> an RFC state...
>>
>> cheers,
>> daniel
>>
>>   gatchat/ppp_net.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
> =

> I went ahead and applied this patch, thanks.

I wonder if we should do something like this here

http://git.kernel.org/?p=3Dnetwork/connman/connman.git;a=3Dcommitdiff;h=3D4=
fe07dfed4f720136ee142e56a9d43242c8c78dc

cheers,
daniel


--===============3937639630512735852==--

