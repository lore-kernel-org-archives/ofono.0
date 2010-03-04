Content-Type: multipart/mixed; boundary="===============6577994968613452633=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 5/7] Add server at command data structure
Date: Thu, 04 Mar 2010 09:40:35 +0800
Message-ID: <4B8F0F93.4030400@intel.com>
In-Reply-To: <201003031323.38102.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6577994968613452633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/04/2010 03:23 AM, Denis Kenzior wrote:
> Hi Zhenhua,
>
>> ---
>>   struct _GAtServer;
>> @@ -46,6 +47,26 @@ enum _GAtServerResult {
>>
>>   typedef enum _GAtServerResult GAtServerResult;
>>
>> +enum _GAtServerRequestType {
>> +	G_AT_SERVER_REQUEST_TYPE_NONE,
>
>> +	G_AT_SERVER_REQUEST_TYPE_ACTION,
>
> What exactly does this one mean, how is it different from SET or NONE?

As we discussed, TYPE_ACTION will be removed.

>> +	G_AT_SERVER_REQUEST_TYPE_QUERY,
>> +	G_AT_SERVER_REQUEST_TYPE_SET,
>> +	G_AT_SERVER_REQUEST_TYPE_SUPPORT,
>> +};
>> +
>> +typedef enum _GAtServerRequestType GAtServerRequestType;
>> +
>> +enum _GAtServerCommandType {
>> +	G_AT_SERVER_COMMAND_TYPE_ACTION,
>> +	G_AT_SERVER_COMMAND_TYPE_PARAMETER,
>
> Again, what do these mean?  Might want to include a simple comment here.

This enum will be removed as well.

>> +};
>> +
>> +typedef enum _GAtServerCommandType GAtServerCommandType;
>> +
>> +typedef int (*GAtServerNotifyFunc)(GAtServerRequestType type, GAtResult
>>   *result, +					gpointer user_data);
>> +
>>   GAtServer *g_at_server_new(GIOChannel *io);
>>
>>   GAtServer *g_at_server_ref(GAtServer *server);
>>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============6577994968613452633==--

