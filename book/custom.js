<script>
// Apply styling to text code blocks (spells) after page load
document.addEventListener('DOMContentLoaded', function() {
  const textBlocks = document.querySelectorAll('pre.text, pre[class="text"]');
  textBlocks.forEach(function(block) {
    block.style.backgroundColor = '#fff4e6';
    block.style.borderLeft = '4px solid #ff9800';
    block.style.padding = '0.8em 1em';
    block.style.margin = '1em 0';
    
    const code = block.querySelector('code');
    if (code) {
      code.style.backgroundColor = 'transparent';
    }
  });
});
</script>
