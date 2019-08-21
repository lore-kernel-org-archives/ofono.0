Content-Type: multipart/mixed; boundary="===============8089964661752563542=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/3] Revert "gprs: _cid_activated is an 'attaching'
 state"
Date: Wed, 21 Aug 2019 13:30:37 -0500
Message-ID: <518d2bb9-02fa-d794-5dff-9efd09abcb18@gmail.com>
In-Reply-To: <4a96c48e-91aa-0948-0dbc-d0fe8a7d3310@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8089964661752563542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard, Jonas,

On 8/21/19 1:01 AM, Jonas Bonn wrote:
> Hi Richard,
> =

> On 20/08/2019 17:56, richard.rojfors(a)gmail.com wrote:
>> From: Richard R=C3=B6jfors <richard@puffinpack.se>
>>
>> This reverts commit 1fd419e5b4b3a87673f8e0219edb0f3ed9fca774.
> =

> This patch is fine and certainly necessary in the context of this =

> series.=C2=A0 Posting it as a 'revert', however, is a bit unsavoury.
> =

> A reverted patch implies that it was somehow wrong or inappropriate. =

> That's not the case here.=C2=A0 This code has become superfluous in the f=
ace =

> of other changes that have been made in the tree.
> =

> Just squash these two revert patches into one "forward looking" patch. =

> The fact that the change effectively constitutes a 'revert' is moot.
> =


So what I ended up doing was to squash patch 2 & 3 and reword the =

description a bit, dropping the 'revert' heading per your wishes.  Let =

me know if you're fine with that.

Otherwise, all 3 applied.

Regards,
-Denis

--===============8089964661752563542==--

