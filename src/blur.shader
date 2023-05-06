/*
 * This is a custom shader for OBS that I’m loading via Exeldro’s
 * obs-shaderilter (https://github.com/exeldro/obs-shaderfilter).
 *
 * It’s a blur filter that I more or less copy-pasted from this great article
 * by Ville-Veikko Urrila and ported over to use OBS’s flavor of HLSL: 
 * https://tech.innogames.com/shader-exploration-the-art-of-blurring/
 */

uniform float blur_amount<
  string label = "Blur Amount (default: 10.0)"
  string widget_type = "slider";
  float minimum = 0.;
  float maximum = 20.;
  float step = 1.;
> = 10.;

uniform string notes = "Baby’s first blur filter";

float4 mainImage(VertData v_in) : TARGET
{
  float4 color = float4(0);
  int start_point = int(blur_amount / 2) * -1;
  int end_point = int(blur_amount / 2)  + 1;

  for (int x = start_point; x < end_point; x++)
  {
    for (int y = start_point; y < end_point; y++)
    {
      vec2 offset = vec2(x, y) / uv_size.xy;
      color += image.Sample(textureSampler, v_in.uv + offset);
    }
  }

  color /= (blur_amount * blur_amount);

  return color;
}
