Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF5E2D8DB0
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533620; cv=none; b=f7M/Kcux5+ZNpHTz1lTniwU5qAMmmAVT+CS73lUYw57MM+ECTRR18WfyaQ7chYUcJVFoTgi1qPVyx24w0dPJabYL/KsdnUG6ha6TvdDXLyVr++hy0LPDAs1CQTCl2bmDT0vjJeW0qWVNsmJoQqq6OOT/c1EYzpcFU1ZBgPeAi+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533620; c=relaxed/simple;
	bh=VF1CE9VuBu8/5xPPA2yX3hltPJF6iK/LTBfpV858IYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FqIDAAAon1sd3BON+3wj+YVXSq3T9Mvm90DdtjOEr0FQE2kIfWuC1YBnyWNE/ITEpkpJy3Bu368bns6N0TbXQWBKzOF4jEOog4u5/DO+37H3/z/x7e1t2Mt8IHWgnlbWL//a6ZLLohezQLWI0PdYEDOv+t2BFEuKKZeNhmuwiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 70377114C1C; Fri, 12 Dec 2025 05:00:17 -0500 (EST)
Received: from [192.168.12.220] (unknown [172.56.164.103])
	by spindle.queued.net (Postfix) with ESMTPSA id 19568114C07;
	Fri, 12 Dec 2025 05:00:17 -0500 (EST)
Message-ID: <05b3a598-5b0a-440e-a294-8e0807e005b2@queued.net>
Date: Fri, 12 Dec 2025 05:00:15 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/10] plugins/udevng: Add support for PCIe MBIM modems
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
 <20251128173656.55692-3-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Andres Salomon <dilinger@queued.net>
Cc: ofono <ofono@lists.linux.dev>
Autocrypt: addr=dilinger@queued.net; keydata=
 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
In-Reply-To: <20251128173656.55692-3-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On 11/28/25 12:36, Muhammad Asif wrote:
> Parses through the sysfs tree and detects MBIM control nodes, net and
> AT nodes
> ---
>   plugins/udevng.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 18954d44..e779524c 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1182,6 +1182,80 @@ static gboolean setup_quectelqmi(struct modem_info *modem)
>   	return TRUE;
>   }
>   

FYI, when I said earlier about a comment, what I meant was something 
describing what's happening here overall. Eg, "/* traverse entries in 
the /sys/class/wwan/ directory looking for control nodes where 
wwanX/type == MBIM and/or AT. */"

With the correct text to describe what the function is actually doing, 
of course. :)


> +static void setup_mbim_pci(struct device_info *info,
> +				const char **ctl,
> +				const char **net,
> +				const char **atcmd)
> +{
> +	struct udev *udev = udev_new();
 > +	struct udev_device *wwan_device, *sub_device;> +
> +	GDir *dir = NULL, *subdir = NULL;
> +	const gchar *filename = NULL, *subfile = NULL;
> +	gchar *path = NULL;
> +	gchar *wwan_path = NULL, *sub_path = NULL;
> +	const char *sub_subsystem = NULL;
> +	const char *type = NULL;
 > +> +	/* Create a path to the WWAN subsystem in sysfs */
> +	path = g_build_path("/", udev_device_get_syspath(info->udev_device),
> +							"wwan", NULL);
> +
> +	dir = g_dir_open(path, 0, NULL);
> +	if (!dir)
> +		goto cleanup;
> +
> +	while ((filename = g_dir_read_name(dir))) {
> +		/* Build a path to the WWAN interface (e.g. wwan0) */
> +		wwan_path = g_build_path("/", path,
> +							filename, NULL);
> +
> +		wwan_device = udev_device_new_from_syspath(udev,
> +							wwan_path);
 > +		*net = g_strdup(udev_device_get_sysname(wwan_device));

This string will be leaked, along with 'net' and 'atcmd' strings below 
once ofono_modem_set_string() is done with them in the calling function. 
I wonder if there's a better way to handle this? Eg, returning a bool 
from this function if ctl/net/atcmd should be g_free()'d after 
ofono_modem_set_string() is called? Or some other better way to handle this.




> +
> +		/* Parse all the subdirectories now */
> +		subdir = g_dir_open(wwan_path, 0, NULL);
 > +		if (!g_file_test(wwan_path, G_FILE_TEST_IS_DIR) ||> +				!subdir) {
> +			udev_device_unref(wwan_device);
> +			g_free(wwan_path);
> +			continue;
> +		}

It feels weird to g_dir_open() first, and *then* do a g_file_test to 
determine if it's a directory. Perhaps it's better to do something like 
this?

if (!g_file_test(wwan_path, G_FILE_TEST_IS_DIR) ||
	!(subdir = g_dir_open(wwan_path, 0, NULL)) {


Also, if there's multiple entries in the wwan directory, won't *net be 
allocated for each one and overwritten/leaked? I'm not entirely clear 
what's going on there, which is why I suggest a comment that describes 
what the wwan directory layout on your Yoga X1 looks like.


> +
> +		while ((subfile = g_dir_read_name(subdir))) {
> +			/* Build a path to the subsystems for the WWAN control nodes */
> +			sub_path = g_build_filename("/", wwan_path,
> +									subfile, NULL);
> +
> +			sub_device = udev_device_new_from_syspath(udev,
> +								sub_path);
> +			sub_subsystem = udev_device_get_subsystem(sub_device);
> +
> +			if (g_strcmp0(sub_subsystem, "wwan") == 0) {
> +				type = udev_device_get_sysattr_value(sub_device, "type");
> +
> +				/* Detect the subsystem of the subdirectories */
> +				if (g_strcmp0(type, "MBIM") == 0)
> +					*ctl = g_strdup(udev_device_get_devnode(sub_device));
> +				else if (g_strcmp0(type, "AT") == 0)
> +					*atcmd = g_strdup(udev_device_get_devnode(sub_device));
> +			}
> +
> +			udev_device_unref(sub_device);
> +			g_free(sub_path);
> +		}
> +		g_dir_close(subdir);
> +		udev_device_unref(wwan_device);
> +		g_free(wwan_path);
> +	}
> +
> +cleanup:
> +	g_dir_close(dir);
> +	g_free(path);
 > +	udev_unref(udev);> +}
> +
>   static gboolean setup_mbim(struct modem_info *modem)
>   {
>   	const char *ctl = NULL, *net = NULL, *atcmd = NULL;
> @@ -1206,7 +1280,8 @@ static gboolean setup_mbim(struct modem_info *modem)
>   		else if (g_strcmp0(subsystem, "tty") == 0) {
>   			if (g_strcmp0(info->number, "02") == 0)
>   				atcmd = info->devnode;
> -		}
> +		} else if (g_strcmp0(subsystem, "pci") == 0)
> +			setup_mbim_pci(info, &ctl, &net, &atcmd);
>   	}
>   
>   	if (ctl == NULL || net == NULL)

